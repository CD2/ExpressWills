require 'spec_helper'

describe "personal_gift_permissions/show" do
  before(:each) do
    @personal_gift_permission = assign(:personal_gift_permission, stub_model(PersonalGiftPermission,
      :permission => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
