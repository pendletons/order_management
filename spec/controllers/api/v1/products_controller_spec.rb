require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

  describe "#create" do
    let(:attr) { attributes_for(:product) }
    subject { post :create, product: attr, format: :json }

    context "with valid attributes" do
      it "creates a product" do
        expect { subject }.to change{Product.count}.by(1)
      end

      it "renders the product in JSON" do
        subject
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response).to eq(product: attr.merge(id: Product.last.id))
      end

      it "succeeds" do
        subject
        expect(response.status).to eq(201)
      end
    end

    context "with invalid attributes" do
      let(:attr) { attributes_for(:product).except(:name) }

      it "does not create a product" do
        expect { subject }.not_to change{Product.count}
      end

      it "renders the errors in JSON" do
        subject
        product = JSON.parse(response.body, symbolize_names: true)
        expect(product[:errors]).to eq(name: ["can't be blank"])
      end

      it "fails" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe "#show" do
    let(:product) { create(:product) }
    subject { get :show, id: product, format: :json }

    context "with valid product" do
      it "renders the product in JSON" do
        subject
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response).to eq(product: product.attributes.symbolize_keys.except(:created_at, :updated_at))
      end

      it "succeeds" do
        subject
        expect(response.status).to eq(200)
      end
    end
  end

  describe "#update" do
    let(:product) { create(:product) }
    let(:attr) { attributes_for(:product).merge(price: 2000) }

    before { put :update, id: product, product: attr, format: :json }

    context "with valid attributes" do
      it "updates the product" do
        subject
        expect(product.reload.price).to eq 2000
      end

      it "renders the product in JSON" do
        subject
        product_response = JSON.parse(response.body, symbolize_names: true)
        expect(product_response).to eq(product: attr.merge(id: product.id))
      end

      it "succeeds" do
        subject
        expect(response.status).to eq(200)
      end
    end

    context "with invalid attributes" do
      let(:attr) { attributes_for(:product).merge(price: "moneyz") }

      it "does not update the product" do
        subject
        expect(product.price).to eq 1000
      end

      it "renders the errors in JSON" do
        subject
        product = JSON.parse(response.body, symbolize_names: true)
        expect(product[:errors]).to eq(price: ["is not a number"])
      end

      it "fails" do
        subject
        expect(response.status).to eq(422)
      end
    end
  end

  describe "#destroy" do
    let(:product) { create(:product) }

    subject { delete :destroy, id: product, format: :json }

    context "with existing orders" do
      it "does not delete the product" do
        expect { subject }.not_to change{Product.count}
      end
    end

    context "with no orders" do
      it "deletes the product" do
        expect { subject }.to change{Product.count}.by(-1)
      end
    end
  end
end
