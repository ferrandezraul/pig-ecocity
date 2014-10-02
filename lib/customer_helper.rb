class CustomerHelper

  # Return array with names of customers
  def self.names( customers )
    customer_names = []
    customers.each do |customer|
      customer_names << customer.name
    end
    customer_names
  end

  # Return customer with given name
  # raises an exception if not found
  def self.find_customer_with_name( customers, name )
    customers.each do |customer|
      if customer.name == name
        return customer
      end
    end

    raise CustomerHelperError.new, "Customer not found."
  end

end