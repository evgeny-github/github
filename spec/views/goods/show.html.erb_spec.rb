require 'spec_helper'

describe "goods/show.html.erb" do
  before(:each) do
    @good = assign(:good, stub_model(Good,
      :title => "Title",
      :count => 1,
      :price => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
