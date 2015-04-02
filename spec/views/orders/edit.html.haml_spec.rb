require 'spec_helper'

describe "orders/edit" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :full_name => "MyString",
      :email_address => "MyString",
      :will_id => 1
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_path(@order), "post" do
      assert_select "input#order_full_name[name=?]", "order[full_name]"
      assert_select "input#order_email_address[name=?]", "order[email_address]"
      assert_select "input#order_will_id[name=?]", "order[will_id]"
    end
  end
end
