class StaticPagesController < ApplicationController

    def welcome 
        @user = User.all;
    end
end
