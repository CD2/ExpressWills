require 'spec_helper'

describe "personal_gift_permissions/edit" do
  before(:each) do
    @personal_gift_permission = assign(:personal_gift_permission, stub_model(PersonalGiftPermission,
      :permission => false
    ))
  end

  it "renders the edit personal_gift_permission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", personal_gift_permission_path(@personal_gift_permission), "post" do
      assert_select "input#personal_gift_permission_permission[name=?]", "personal_gift_permission[permission]"
    end
  end
end
