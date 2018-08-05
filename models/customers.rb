require_relative("../db/sql_runner")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @funds = options["funds"]
  end

  # CREATE
  def save()
    sql = "INSERT INTO customers(name, funds) VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    location = SqlRunner.run(sql, values).first
    @id = location['id'].to_i
  end

  #READ
  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map {|customers| Customer.new(customers)}
    return result
  end

  #UPDATE
  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  #DELETE
  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  #Find all films for customer
  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map {|film| Film.new(film)}
  end

  # --- extensions
  #Buying ticket
  #Somehow this function was first only working for customer1 (from 100 to 97), and not for cust2, and after re-running the console it only works for cust2 and not for cust1? They should be identical so not idea where the problem lies
  def buy_ticket()
    sql = "SELECT SUM (films.price) FROM films INNER JOIN tickets ON films.price = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    return @funds - result['sum'].to_i
  end

  def film_count()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.count
  end


end
