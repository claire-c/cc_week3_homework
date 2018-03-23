require('pry')
require('pg')
require_relative('../db/sql_runner')
require_relative('film.rb')
require_relative('customer.rb')

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize(ticket_hash)
    @customer_id = ticket_hash['customer_id'].to_i
    @film_id = ticket_hash['film_id'].to_i
    @id = ticket_hash['id'].to_i if ticket_hash['id']
  end


  def save()
    sql = "
    INSERT INTO tickets
    (customer_id, film_id)
    VALUES
    ($1, $2)
    RETURNING id;
    "
    values = [@customer_id, @film_id]
    hash = SqlRunner.run(sql, values)
    @id = hash[0]['id']
  end

  def self.delete_all
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def update()
    sql = "
      UPDATE tickets
      SET (customer_id, film_id) =
      ($1, $2)
      WHERE id = $3;
      "
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.get_all()
    sql = "SELECT * FROM tickets;"
    result_array = SqlRunner.run(sql)
    tickets = result_array.map { |ticket| Ticket.new(ticket)}
    return tickets
  end


end
