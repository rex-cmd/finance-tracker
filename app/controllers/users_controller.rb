class UsersController < ApplicationController
    def my_portfolio
        @tracked_stocks = current_user.stocks
    end
    def my_friends
        @followed_friends= current_user.friends
    end
end