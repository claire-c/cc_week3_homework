require('pry')
require('pg')
require_relative('film.rb')
require_relative('../db/sql_runner.rb')
require_relative('tickets.rb')

class Customer

attr_reader :id
attr_accessor :name, :funds

  def initialize(customer_hash)
    @name = customer_hash['name']
    @funds = customer_hash['funds'].to_i
    @id = customer_hash['id'].to_i if customer_hash['id']
  end


end
