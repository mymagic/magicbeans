require 'rails_helper'

RSpec.describe "programs/new", :type => :view do
  before(:each) do
    assign(:program, Program.new(
      :name => "MyString",
      :description => "MyString",
      :speaker => "MyString",
      :speakerbio => "MyString",
      :biourl => "MyString",
      :keytakeways => "MyString",
      :tags => "MyString",
      :resources => "MyString"
    ))
  end

  it "renders new program form" do
    render

    assert_select "form[action=?][method=?]", programs_path, "post" do

      assert_select "input#program_name[name=?]", "program[name]"

      assert_select "input#program_description[name=?]", "program[description]"

      assert_select "input#program_speaker[name=?]", "program[speaker]"

      assert_select "input#program_speakerbio[name=?]", "program[speakerbio]"

      assert_select "input#program_biourl[name=?]", "program[biourl]"

      assert_select "input#program_keytakeways[name=?]", "program[keytakeways]"

      assert_select "input#program_tags[name=?]", "program[tags]"

      assert_select "input#program_resources[name=?]", "program[resources]"
    end
  end
end
