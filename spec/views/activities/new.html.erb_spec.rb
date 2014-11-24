require 'rails_helper'

RSpec.describe "activities/new", :type => :view do
  before(:each) do
    assign(:activity, Activity.new(
      :name => "MyString",
      :date => "MyString",
      :venue => "MyString",
      :description => "MyText",
      :speaker => "MyString",
      :speakerbio => "MyText",
      :biolink => "MyString",
      :keytakeaway => "MyString",
      :prerequisite => "MyText",
      :maxattendee => 1,
      :tags => "MyString",
      :resources => "MyString"
    ))
  end

  it "renders new activity form" do
    render

    assert_select "form[action=?][method=?]", activities_path, "post" do

      assert_select "input#activity_name[name=?]", "activity[name]"

      assert_select "input#activity_date[name=?]", "activity[date]"

      assert_select "input#activity_venue[name=?]", "activity[venue]"

      assert_select "textarea#activity_description[name=?]", "activity[description]"

      assert_select "input#activity_speaker[name=?]", "activity[speaker]"

      assert_select "textarea#activity_speakerbio[name=?]", "activity[speakerbio]"

      assert_select "input#activity_biolink[name=?]", "activity[biolink]"

      assert_select "input#activity_keytakeaway[name=?]", "activity[keytakeaway]"

      assert_select "textarea#activity_prerequisite[name=?]", "activity[prerequisite]"

      assert_select "input#activity_maxattendee[name=?]", "activity[maxattendee]"

      assert_select "input#activity_tags[name=?]", "activity[tags]"

      assert_select "input#activity_resources[name=?]", "activity[resources]"
    end
  end
end
