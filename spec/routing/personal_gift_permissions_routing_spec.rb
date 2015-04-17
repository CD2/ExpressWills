require "spec_helper"

describe PersonalGiftPermissionsController do
  describe "routing" do

    it "routes to #index" do
      get("/personal_gift_permissions").should route_to("personal_gift_permissions#index")
    end

    it "routes to #new" do
      get("/personal_gift_permissions/new").should route_to("personal_gift_permissions#new")
    end

    it "routes to #show" do
      get("/personal_gift_permissions/1").should route_to("personal_gift_permissions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/personal_gift_permissions/1/edit").should route_to("personal_gift_permissions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/personal_gift_permissions").should route_to("personal_gift_permissions#create")
    end

    it "routes to #update" do
      put("/personal_gift_permissions/1").should route_to("personal_gift_permissions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/personal_gift_permissions/1").should route_to("personal_gift_permissions#destroy", :id => "1")
    end

  end
end
