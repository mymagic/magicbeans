require 'rails_helper'

RSpec.describe User, :type => :model do
   it{is_expected.to respond_to:name}
end
