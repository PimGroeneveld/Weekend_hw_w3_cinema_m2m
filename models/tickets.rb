require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @customer_id = options["customer_id"]
    @film_id = options["film_id"]
  end

  # CREATE
  def save()
    sql = "INSERT INTO tickets(customer_id, film_id) VALUES ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    location = SqlRunner.run(sql, values).first
    @id = location['id'].to_i
  end

  #READ
  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    ticket = SqlRunner.run(sql, values)
    result = ticket.map {|tickets| Ticket.new(tickets)}
    return result
  end

  #UPDATE
  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  #DELETE
  def self.delete_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #-----------
  #Which customer belongs to which ticket
  def customer()  #in the tickets (join) table so we can grab customer_id easily, the _id's are already bundled in this table
    sql = "SELECT * FROM customers WHERE id = $1"
    values  = [@customer_id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  #which film belongs to which ticket
  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql, values).first
    return Film.new(film)
  end


end
