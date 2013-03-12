require 'spec_helper'

describe "baskets/index.html.erb" do
  before(:each) do
    assign(:baskets, [
      stub_model(Basket,
        :user_id => 1,
        :good_id => 1,
        :count => 1,
        :price => 1
      ),
      stub_model(Basket,
        :user_id => 1,
        :good_id => 1,
        :count => 1,
        :price => 1
      )
    ])
  end

  it "renders a list of baskets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
