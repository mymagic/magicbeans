require 'rails_helper'

RSpec.describe "programs/index", :type => :view do
  before(:each) do
    assign(:programs, [
      Program.create!(
        :name => "Name",
        :description => "Description",
        :speaker => "Speaker",
        :speakerbio => "Speakerbio",
        :biourl => "Biourl",
        :keytakeways => "Keytakeways",
        :tags => "Tags",
        :resources => "Resources"
      ),
      Program.create!(
        :name => "Name",
        :description => "Description",
        :speaker => "Speaker",
        :speakerbio => "Speakerbio",
        :biourl => "Biourl",
        :keytakeways => "Keytakeways",
        :tags => "Tags",
        :resources => "Resources"
      )
    ])
  end

  it "renders a list of programs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Speaker".to_s, :count => 2
    assert_select "tr>td", :text => "Speakerbio".to_s, :count => 2
    assert_select "tr>td", :text => "Biourl".to_s, :count => 2
    assert_select "tr>td", :text => "Keytakeways".to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
    assert_select "tr>td", :text => "Resources".to_s, :count => 2
  end
end
