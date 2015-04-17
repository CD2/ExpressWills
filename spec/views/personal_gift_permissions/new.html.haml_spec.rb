require 'spec_helper'

describe "personal_gift_permissions/new" do
  before(:each) do
    assign(:personal_gift_permission, stub_model(PersonalGiftPermission,
      :permission => false
    ).as_new_record)
  end

  it "renders new personal_gift_permission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", personal_gift_permissions_path, "post" do
      assert_select "input#personal_gift_permission_permission[name=?]", "personal_gift_permission[permission]"
    end
  end
end
