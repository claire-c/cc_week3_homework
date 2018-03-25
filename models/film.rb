require('pry')
require('pg')
require_relative('../db/sql_runner.rb')
require_relative('customer.rb')
require_relative('screening.rb')
require_relative('ticket.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(film_hash)
    @title = film_hash['title']
    @price = film_hash['price'].to_i
    @id = film_hash['id'].to_i if film_hash['id']
  end

  def save()
    sql = "
    INSERT INTO films
    (title, price)
    VALUES
    ($1, $2)
    RETURNING id;
    "
    values = [@title, @price]
    hash = SqlRunner.run(sql, values)
    @id = hash[0]['id']
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def update()
    sql = "
      UPDATE films
      SET (title, price) =
      ($1, $2)
      WHERE id = $3;
      "
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.get_all()
    sql = "SELECT * FROM films;"
    result_array = SqlRunner.run(sql)
    films = result_array.map { |film| Film.new(film)}
    return films
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1 "
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #which customers are coming to see one film.
  def get_customers()
    sql = "
      SELECT customers.* FROM customers
        INNER JOIN tickets
        ON tickets.customer_id = customers.id
        WHERE film_id = $1;
        "
    values = [@id]
    array = SqlRunner.run(sql, values)
    customers = array.map {|customer| Customer.new(customer)}
    return customers
  end

  def get_customer_headcount()
    customers_array = get_customers()
    return customers_array.length
  end

  def most_popular_screening()
    sql = "
      SELECT COUNT(screenings.time), screenings.time
        FROM tickets
        INNER JOIN films ON tickets.film_id = films.id
        INNER JOIN screenings ON tickets.screening_id = screenings.id
        WHERE films.id = $1
        GROUP BY screenings.time
        ORDER BY COUNT(screenings.time) DESC
        LIMIT 1;
      "
    values = [@id]
    array = SqlRunner.run(sql, values)
    return array[0]
  end

  def find_screenings()
    sql = "
      SELECT * from screenings
        WHERE screenings.film_id = $1;"

    values = [@id]
    array = SqlRunner.run(sql, values)
    screenings = array.map { |screening| Screening.new(screening) }
    return screenings
  end


end
