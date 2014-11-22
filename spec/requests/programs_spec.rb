require 'rails_helper'

RSpec.describe "Programs", :type => :request do
  describe "GET /programs" do
    it "works! (now write some real specs)" do
      get programs_path
      expect(response.status).to be(200)
    end
  end
end
