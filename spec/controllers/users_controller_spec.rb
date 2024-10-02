require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    {
      name: 'sanchojuniorce',
      address_web: 'http://example.com',
      github_username: 'sanchojuniorce',
      followers: 10,
      following: 5,
      stars: 15,
      contributions: 20,
      profile_image_url: 'https://avatars.githubusercontent.com/u/1126148?v=4',
      organization: 'Test Org',
      location: 'Test City'
    }
  }

  let(:user) { User.create!(valid_attributes) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the users path" do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(users_path)
      end
    end

    context "with invalid params" do
      it "does not create a new User" do
        expect {
          post :create, params: { user: { name: nil } }
        }.to change(User, :count).by(0)
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the requested user" do
        patch :update, params: { id: user.to_param, user: { name: 'chavez' } }
        user.reload
        expect(user.name).to eq('chavez')
      end

      it "redirects to the users path" do
        patch :update, params: { id: user.to_param, user: valid_attributes }
        expect(response).to redirect_to(users_path)
      end
    end

    context "with invalid params" do
      it "does not update the user" do
        patch :update, params: { id: user.to_param, user: { name: nil } }
        user.reload
        expect(user.name).not_to be_nil
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user
      expect {
        delete :destroy, params: { id: user.to_param }
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users path" do
      delete :destroy, params: { id: user.to_param }
      expect(response).to redirect_to(users_path)
    end
  end
end
