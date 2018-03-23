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


end
