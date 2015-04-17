require 'spec_helper'

describe "personal_gift_permissions/index" do
  before(:each) do
    assign(:personal_gift_permissions, [
      stub_model(PersonalGiftPermission,
        :permission => false
      ),
      stub_model(PersonalGiftPermission,
        :permission => false
      )
    ])
  end

  it "renders a list of personal_gift_permissions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
