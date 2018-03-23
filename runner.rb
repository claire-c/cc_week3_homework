require('pry')
require('pg')
require_relative('db/sql_runner')
require_relative('models/film.rb')
require_relative('models/customer.rb')
require_relative('models/ticket.rb')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

claire = Customer.new({'name' => 'Claire', 'funds' => '50'})
mike = Customer.new({'name' => 'Mike', 'funds' => '25'})
simon = Customer.new({'name' => 'Simon', 'funds' => '10'})
rachel = Customer.new({'name' => 'Rachel', 'funds' => '40'})

claire.save()
mike.save()
simon.save()
rachel.save()

jaws = Film.new({'title' => 'Jaws', 'price' => '10'})
alien = Film.new({'title' => 'Alien', 'price' => '5'})
terminator = Film.new({'title' => 'Terminator', 'price' => '8'})
et = Film.new({'title' => 'ET', 'price' => '3'})

jaws.save()
alien.save()
terminator.save()
et.save()

ticket1 = Ticket.new({'customer_id' => claire.id, 'film_id' => alien.id})
ticket2 = Ticket.new({'customer_id' => claire.id, 'film_id' => jaws.id})
ticket3 = Ticket.new({'customer_id' => mike.id, 'film_id' => alien.id})
ticket4 = Ticket.new({'customer_id' => simon.id, 'film_id' => terminator.id})
ticket5 = Ticket.new({'customer_id' => rachel.id, 'film_id' => et.id})

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()

 ticket1.delete()
# claire.delete()
# jaws.delete(
