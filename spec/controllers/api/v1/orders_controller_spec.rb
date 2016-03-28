require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

  describe "#create" do
    let(:attr) { attributes_for(:order) }
    subject { post :create, order: attr, format: :json }

    context "with valid attributes" do
      it "creates an order" do
        expect { subject }.to change{Order.count}.by(1)
      end

      it "renders the order in JSON" do
        subject
        order_response = JSON.parse(response.body, symbolize_names: true)
        expect(order_response).to eq(order: {
                                              id: Order.last.id,
                                              order_date: attr[:order_date].to_s
                                            })
      end

      it "succeeds" do
        subject
        expect(response.status).to eq(201)
      end
    end

    context "with invalid attributes" do
      let(:attr) { attributes_for(:order).merge(order_date: 123) }

      it "does not create an order" do
        expect { subject }.not_to change{Order.count}
      end

      it "renders the errors in JSON" do
        subject
        order = JSON.parse(response.body, symbolize_names: true)
        expect(order[:errors]).to eq(order_date: ["is not a date"])
      end

      it "fails" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe "#show" do
    let(:order) { create(:order) }
    subject { get :show, id: order, format: :json }

    context "with valid product" do
      it "renders the order in JSON" do
        subject
        order_response = JSON.parse(response.body, symbolize_names: true)
        expect(order_response).to eq(order: {
                                              id: order.id,
                                              order_date: order.order_date.to_s
                                            })
      end

      it "succeeds" do
        subject
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#update" do
    let(:order) { create(:order) }
    let(:attr) { attributes_for(:order, :order_tomorrow) }

    before { put :update, id: order, order: attr, format: :json }

    context "with valid attributes" do
      let(:new_date) { Date.current + 1.day }

      it "updates the order" do
        subject
        expect(order.reload.order_date).to eq new_date
      end

      it "renders the order in JSON" do
        subject
        order_response = JSON.parse(response.body, symbolize_names: true)
        expect(order_response).to eq(order: {
                                              id: order.id,
                                              order_date: new_date.to_s
                                            })
      end

      it "succeeds" do
        subject
        expect(response.status).to eq(200)
      end
    end

    context "with invalid attributes" do
      let(:attr) { attributes_for(:order).merge(order_date: 321) }

      it "does not update the order" do
        subject
        expect(order.order_date).to eq Date.current
      end

      it "renders the errors in JSON" do
        subject
        order = JSON.parse(response.body, symbolize_names: true)
        expect(order[:errors]).to eq(order_date: ["is not a date"])
      end

      it "fails" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end
end
