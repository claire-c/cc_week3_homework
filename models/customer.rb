require('pry')
require('pg')
require_relative('film.rb')
require_relative('../db/sql_runner.rb')
require_relative('ticket.rb')
require_relative('screening.rb')
require_relative('film.rb')

class Customer

attr_reader :id
attr_accessor :name, :funds

  def initialize(customer_hash)
    @name = customer_hash['name']
    @funds = customer_hash['funds'].to_i
    @id = customer_hash['id'].to_i if customer_hash['id']
  end

  def save()
    sql = "
    INSERT INTO customers
    (name, funds)
    VALUES
    ($1, $2)
    RETURNING id;
    "
    values = [@name, @funds]
    hash = SqlRunner.run(sql, values)
    @id = hash[0]['id']
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def update()
    sql = "
      UPDATE customers
      SET (name, funds) =
      ($1, $2)
      WHERE id = $3;
      "
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.get_all()
    sql = "SELECT * FROM customers;"
    result_array = SqlRunner.run(sql)
    customers = result_array.map { |customer| Customer.new(customer)}
    return customers
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1 "
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def show_booked_films()
    sql = "
      SELECT * FROM films
        INNER JOIN tickets
        ON films.id = tickets.film_id
        WHERE customer_id = $1"
    values = [@id]
    array = SqlRunner.run(sql, values)
    booked_films = array.map { |film| Film.new(film)}
    return booked_films
  end

  def get_ticket_totals()
    tickets = show_booked_films()
    return tickets.length()
  end
  #
  # def pay_for_ticket(film)
  #   s = Screening.find_for_film(film_id)
  #   if s.num_tickets > 0
  #     # t = Ticket.new(....)
  #     # t.save()
  #     @funds -= film.price
  #     update()
  #     s.num_tickets -= 1
  #     s.update()
  #    else
  #      return nil
  #    end
  # end

end
