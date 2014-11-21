require 'rails_helper'

RSpec.describe User, :type => :model do
   
   it{is_expected.to respond_to:name}
   it{is_expected.to respond_to:ic}
   it{is_expected.to respond_to:phone}
   
   describe 'when creating user' do
       context 'with valid data' do
           let(:user){User.new(name:'azri bin mohd khanil',ic:'921006-02-5425',phone:'019-5703962')}
           subject{user}
           it{is_expected.to be_valid}
       end
       
       
       context 'with invalid data' do
           context 'where name is blank' do
                let(:invalid_user){User.new(ic:'921006-02-5425',phone:'019-5703962')}
                subject{invalid_user}
                it{is_expected.to_not be_valid}    
           end
       end
       
       
   end
   
   
end
