require_relative("models/tickets")
require_relative("models/films")
require_relative("models/customers")

require ("pry-byebug")

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  "name" => "Louis",
  "funds" => 100
  })

customer1.save()

customer2 = Customer.new({
  "name" => "Pim",
  "funds" => 80
  })

customer2.save()

customer3 = Customer.new({
  "name" => "Pete",
  "funds" => 50
  })

customer3.save()

film1 = Film.new({
  "title" => "Kung Fury",
  "price" => 3
  })

film1.save()

film2 = Film.new({
  "title" => "Big Fish",
  "price" => 8
  })

film2.save()

ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film1.id
  })

ticket1.save()

ticket2 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film2.id
  })

ticket2.save()

ticket3 = Ticket.new({
  "customer_id" => customer3.id,
  "film_id" => film1.id
  })

ticket3.save()

binding.pry
nil
