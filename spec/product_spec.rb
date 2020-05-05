require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "is not valid with null name" do
      @category = Category.create(name: "USB")
      @product = @category.products.create(name: "2GB", quantity: 2, price_cents: 2)
      @product.name = nil
      expect(@product).to_not be_valid
    end

    it "is not valid with null quantity" do
      @category = Category.create(name: "USB")
      @product = @category.products.create(name: "2GB", quantity: 2, price_cents: 2)
      @product.quantity = nil
      expect(@product).to_not be_valid
    end

    it "is not valid with null price_cents" do
      @category = Category.create(name: "USB")
      @product = @category.products.create(name: "2GB", quantity: 2, price_cents: 2)
      @product.price_cents = nil
      expect(@product).to_not be_valid
    end

    it "is not valid with null category" do
      @category = Category.create(name: "USB")
      @product = @category.products.create(name: "2GB", quantity: 2, price_cents: 2)
      @product.category = nil
      expect(@product).to_not be_valid
      # @product.errors.full_messages
    end

    it "is valid with valid attributes" do
      @category = Category.create(name: "USB")
      @product = @category.products.create(name: "2GB", quantity: 2, price_cents: 2)
      expect(@product).to be_valid
    end

  end
end
