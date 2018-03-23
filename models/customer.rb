require('pry')
require('pg')
require_relative('film.rb')
require_relative('../db/sql_runner.rb')
require_relative('ticket.rb')

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

end
