require 'rails_helper'

RSpec.describe "activities/show", :type => :view do
  before(:each) do
    @activity = assign(:activity, Activity.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Date/)
    expect(rendered).to match(/Venue/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Speaker/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Biolink/)
    expect(rendered).to match(/Keytakeaway/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Tags/)
    expect(rendered).to match(/Resources/)
  end
end
