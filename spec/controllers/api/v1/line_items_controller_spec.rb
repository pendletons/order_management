require 'rails_helper'

RSpec.describe Api::V1::LineItemsController, type: :controller do
  let(:order) { create(:order) }
  let(:product) { create(:product) }

  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

  describe "#create" do
    let(:attr) { attributes_for(:line_item).merge(order_id: order.id, product_id: product.id) }
    subject { post :create, line_item: attr, format: :json }

    context "with valid attributes" do
      it "creates a line item" do
        expect { subject }.to change{LineItem.count}.by(1)
      end

      it "renders the line item in JSON" do
        subject
        line_item_response = JSON.parse(response.body, symbolize_names: true)
        expect(line_item_response).to eq(line_item: {
                                                      id: LineItem.last.id,
                                                      order_id: order.id,
                                                      product_id: product.id,
                                                      quantity: attr[:quantity],
                                                      product_name: product.name
                                                    })
      end

      it "succeeds" do
        subject
        expect(response.status).to eq(201)
      end
    end

    context "with invalid attributes" do
      let(:attr) { attributes_for(:line_item).except(:quantity)
                                             .merge(order_id: order.id, product_id: product.id) }

      it "does not create a line item" do
        expect { subject }.not_to change{LineItem.count}
      end

      it "renders the errors in JSON" do
        subject
        line_item = JSON.parse(response.body, symbolize_names: true)
        expect(line_item[:errors]).to eq(quantity: ["can't be blank", "is not a number"])
      end

      it "fails" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe "#show" do
    let(:line_item) { create(:line_item) }
    subject { get :show, id: line_item, format: :json }

    context "with valid line item" do
      it "renders the line item in JSON" do
        subject
        line_item_response = JSON.parse(response.body, symbolize_names: true)
        expect(line_item_response).to eq(line_item: {
                                                      id: line_item.id,
                                                      order_id: line_item.order_id,
                                                      product_id: line_item.product_id,
                                                      quantity: line_item.quantity,
                                                      product_name: line_item.product_name
                                                    })
      end

      it "succeeds" do
        subject
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#update" do
    let(:line_item) { create(:line_item) }
    let(:attr) { attributes_for(:line_item).merge(quantity: 10) }

    before { put :update, id: line_item, line_item: attr, format: :json }

    context "with valid attributes" do
      it "updates the line item" do
        subject
        expect(line_item.reload.quantity).to eq 10
      end

      it "renders the line item in JSON" do
        subject
        line_item_response = JSON.parse(response.body, symbolize_names: true)
        expect(line_item_response).to eq(line_item: {
                                                      id: line_item.id,
                                                      order_id: line_item.order_id,
                                                      product_id: line_item.product_id,
                                                      quantity: attr[:quantity],
                                                      product_name: line_item.product_name
                                                    })
      end

      it "succeeds" do
        subject
        expect(response.status).to eq(200)
      end
    end

    context "with invalid attributes" do
      let(:attr) { attributes_for(:line_item).merge(quantity: "lots") }

      it "does not update the line item" do
        subject
        expect(line_item.reload.quantity).to eq 2
      end

      it "renders the errors in JSON" do
        subject
        line_item = JSON.parse(response.body, symbolize_names: true)
        expect(line_item[:errors]).to eq(quantity: ["is not a number"])
      end

      it "fails" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe "#destroy" do
    let!(:line_item) { create(:line_item) }

    subject { delete :destroy, id: line_item, format: :json }

    context "with an invalid line item" do
      subject { delete :destroy, id: 12345, format: :json }

      it "does not delete the line item" do
        expect { subject }.not_to change{LineItem.count}
      end

      it "fails" do
        subject
        expect(response.status).to eq(422)
      end
    end

    context "with valid line item" do
      it "deletes the line item" do
        expect { subject }.to change{LineItem.count}.by(-1)
      end

      it "succeeds" do
        subject
        expect(response.status).to eq(204)
      end
    end
  end
end
