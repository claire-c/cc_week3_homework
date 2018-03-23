require('pry')
require('pg')
require_relative('../db/sql_runner')
require_relative('film.rb')
require_relative('customer.rb')

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize(ticket_hash)
    @customer_id = ticket_hash['customer_id']
    @film_id = ticket_hash['film_id']
    @id = ticket_hash['id'].to_i if ticket_hash['id']
  end


end
