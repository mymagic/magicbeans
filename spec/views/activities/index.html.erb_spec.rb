require 'rails_helper'

RSpec.describe "activities/index", :type => :view do
  before(:each) do
    assign(:activities, [
      Activity.create!(
        :name => "Name",
        :date => "Date",
        :venue => "Venue",
        :description => "MyText",
        :speaker => "Speaker",
        :speakerbio => "MyText",
        :biolink => "Biolink",
        :keytakeaway => "Keytakeaway",
        :prerequisite => "MyText",
        :maxattendee => 1,
        :tags => "Tags",
        :resources => "Resources"
      ),
      Activity.create!(
        :name => "Name",
        :date => "Date",
        :venue => "Venue",
        :description => "MyText",
        :speaker => "Speaker",
        :speakerbio => "MyText",
        :biolink => "Biolink",
        :keytakeaway => "Keytakeaway",
        :prerequisite => "MyText",
        :maxattendee => 1,
        :tags => "Tags",
        :resources => "Resources"
      )
    ])
  end

  it "renders a list of activities" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Date".to_s, :count => 2
    assert_select "tr>td", :text => "Venue".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Speaker".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Biolink".to_s, :count => 2
    assert_select "tr>td", :text => "Keytakeaway".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
    assert_select "tr>td", :text => "Resources".to_s, :count => 2
  end
end
