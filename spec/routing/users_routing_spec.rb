require 'rails_helper'

RSpec.describe "Routing to Users", type: :routing do
  it "routes to #index" do
    expect(get: "/users").to route_to("users#index")
  end

  it "routes to #new" do
    expect(get: "/users/new").to route_to("users#new")
  end

  it "routes to #create" do
    expect(post: "/users").to route_to("users#create")
  end

  it "routes to #edit" do
    expect(get: "/users/1/edit").to route_to("users#edit", id: "1")
  end

  it "routes to #update" do
    expect(patch: "/users/1").to route_to("users#update", id: "1")
  end

  it "routes to #destroy" do
    expect(delete: "/users/1").to route_to("users#destroy", id: "1")
  end

  it "routes to #profile" do
    expect(get: "/users/1/profile").to route_to("users#profile", id: "1")
  end

  it "routes root to users#index" do
    expect(get: "/").to route_to("users#index")
  end
end
