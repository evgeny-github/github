require 'spec_helper'

describe "goods/new.html.erb" do
  before(:each) do
    assign(:good, stub_model(Good,
      :title => "MyString",
      :count => 1,
      :price => 1
    ).as_new_record)
  end

  it "renders new good form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => goods_path, :method => "post" do
      assert_select "input#good_title", :name => "good[title]"
      assert_select "input#good_count", :name => "good[count]"
      assert_select "input#good_price", :name => "good[price]"
    end
  end
end
