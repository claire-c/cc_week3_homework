require('pry')
require('pg')
require_relative('../db/sql_runner.rb')
require_relative('customer.rb')
require_relative('ticket.rb')
require_relative('film.rb')

class Screening

  attr_reader :id, :film_id
  attr_accessor :time, :remaining_tickets

  def initialize(screening_hash)
    @time = screening_hash['time']
    @film_id = screening_hash['film_id'].to_i
    @remaining_tickets = screening_hash['remaining_tickets'].to_i
    @id = screening_hash['id'].to_i if screening_hash['id']
  end

  def save()
    sql = "
      INSERT INTO screenings
      (time, film_id, remaining_tickets)
      VALUES ($1, $2, $3)
      RETURNING id;
    "
    values = [@time, @film_id, @remaining_tickets]
    array = SqlRunner.run(sql, values)
    @id = array[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end





end
