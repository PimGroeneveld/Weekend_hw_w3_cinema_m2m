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


end
