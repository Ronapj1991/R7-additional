require 'rails_helper'

RSpec.describe "Orders", type: :request do
 describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the customer" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {product_count: 50}}
      order.reload
      expect(order.product_count).to eq(50)
      expect(response).to redirect_to("/orders/#{order.id}")
    end
  end
  describe "put order_path with invalid data" do
    it "does not update the customer record or redirect" do
      order = FactoryBot.create(:order)
      put "/orders/#{order.id}", params: {order: {customer_id: 5001}}
      order.reload
      expect(order.customer_id).not_to eq(5001)
      expect(response).to render_template(:edit)
    end
  end
  describe "get order_path works" do
    it "renders the index view" do
      expect(get "/orders").to render_template(:index)
    end
  end
  describe "get new_order_path" do
    it "renders :new order" do
      expect(get "/orders/new").to render_template(:new)
    end
  end
  describe "get edit path" do
    it "renders the edit template" do
      order = FactoryBot.create(:order)
      expect(get "/orders/#{order.id}/edit").to render_template(:edit)
    end
  end
  describe "delete an order" do
    it "deletes an order record" do
      order = FactoryBot.create(:order)
      order.delete
      expect(response).to be_nil
    end
  end
end
