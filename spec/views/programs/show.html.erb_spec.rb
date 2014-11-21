require 'rails_helper'

RSpec.describe "programs/show", :type => :view do
  before(:each) do
    @program = assign(:program, Program.create!(
      :name => "Name",
      :description => "Description",
      :speaker => "Speaker",
      :speakerbio => "Speakerbio",
      :biourl => "Biourl",
      :keytakeways => "Keytakeways",
      :tags => "Tags",
      :resources => "Resources"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Speaker/)
    expect(rendered).to match(/Speakerbio/)
    expect(rendered).to match(/Biourl/)
    expect(rendered).to match(/Keytakeways/)
    expect(rendered).to match(/Tags/)
    expect(rendered).to match(/Resources/)
  end
end
