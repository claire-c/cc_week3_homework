require('pry')
require('pg')
require_relative('db/sql_runner')
require_relative('models/film.rb')
require_relative('models/customer.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')

Screening.delete_all()
Ticket.delete_all()
Customer.delete_all()
Film.delete_all()



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


alien_morning = Screening.new({'time' => '9am', 'film_id' => alien.id, 'remaining_tickets' => '50' })
alien_afternoon = Screening.new({'time' => '4pm', 'film_id' => alien.id, 'remaining_tickets' => '100' })
jaws_morning = Screening.new({'time' => '10am', 'film_id' => jaws.id, 'remaining_tickets' => '25' })
jaws_afternoon = Screening.new({'time' => '3pm', 'film_id' => jaws.id, 'remaining_tickets' => '4' })
et_morning = Screening.new({'time' => '2pm', 'film_id' => et.id, 'remaining_tickets' => '10' })

alien_morning.save()
alien_afternoon.save()
jaws_morning.save()
jaws_afternoon.save()
et_morning.save()

ticket1 = Ticket.new({'customer_id' => claire.id, 'film_id' => alien.id, 'screening_id' => alien_morning.id })
ticket2 = Ticket.new({'customer_id' => claire.id, 'film_id' => jaws.id, 'screening_id' => jaws_afternoon.id})
ticket3 = Ticket.new({'customer_id' => mike.id, 'film_id' => alien.id, 'screening_id' => alien_morning.id})
ticket4 = Ticket.new({'customer_id' => simon.id, 'film_id' => jaws.id, 'screening_id' => jaws_afternoon.id})
ticket5 = Ticket.new({'customer_id' => rachel.id, 'film_id' => et.id, 'screening_id' => et_morning.id})


ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
#
#
#
# #p claire.show_booked_films()
#
# # Write a method that finds out what is the most popular time (most tickets sold) for a given film
#
# # Limit the available tickets for screenings.
#
# # Add any other extensions you think would be great to have at a cinema! sa
