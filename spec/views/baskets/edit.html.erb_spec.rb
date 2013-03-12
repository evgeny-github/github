require 'spec_helper'

describe "baskets/edit.html.erb" do
  before(:each) do
    @basket = assign(:basket, stub_model(Basket,
      :user_id => 1,
      :good_id => 1,
      :count => 1,
      :price => 1
    ))
  end

  it "renders the edit basket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => baskets_path(@basket), :method => "post" do
      assert_select "input#basket_user_id", :name => "basket[user_id]"
      assert_select "input#basket_good_id", :name => "basket[good_id]"
      assert_select "input#basket_count", :name => "basket[count]"
      assert_select "input#basket_price", :name => "basket[price]"
    end
  end
end
