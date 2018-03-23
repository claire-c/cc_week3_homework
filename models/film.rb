require('pry')
require('pg')
require_relative('../db/sql_runner.rb')
require_relative('customer.rb')
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



end
