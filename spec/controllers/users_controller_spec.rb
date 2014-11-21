require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
    
    context 'get new' do
        it 'assigns @users with All Users in the database' do
            user1 = User.create(name: 'User1', email: 'user1@gmail.com', ic: '111111-11-1111', phone: '010-1111111')
            user2 = User.create(name: 'User2', email: 'user2@gmail.com', ic: '222222-22-2222', phone: '010-2222222')
            
            get :index
            
            expect(assigns(:users)).to eq(User.all)
        end
    end
    
    context 'get index' do
        it 'assigns @users with All Users in the database' do
            user1 = User.create(name: 'User1', email: 'user1@gmail.com', ic: '111111-11-1111', phone: '010-1111111')
            user2 = User.create(name: 'User2', email: 'user2@gmail.com', ic: '222222-22-2222', phone: '010-2222222')
            
            get :index
            
            expect(assigns(:users)).to eq(User.all)
        end
    end
    
    context 'get show/2' do
        it 'assigns @user with the corresponding ID' do
            user1 = User.create(name: 'User1', email: 'user1@gmail.com', ic: '111111-11-1111', phone: '010-1111111')
            user2 = User.create(name: 'User2', email: 'user2@gmail.com', ic: '222222-22-2222', phone: '010-2222222')
            
            get :show, {id: 2}
            
            expect(assigns(:user)).to eq(user2)
        end
    end
    
    context 'get index' do
        it 'assigns @users with All Users in the database' do
            user1 = User.create(name: 'User1', email: 'user1@gmail.com', ic: '111111-11-1111', phone: '010-1111111')
            user2 = User.create(name: 'User2', email: 'user2@gmail.com', ic: '222222-22-2222', phone: '010-2222222')
            
            get :index
            
            expect(assigns(:users)).to eq(User.all)
        end
    end
end
