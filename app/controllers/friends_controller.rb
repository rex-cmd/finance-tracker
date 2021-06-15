class FriendsController < ApplicationController
    def search
        if params[:user].present?
            @friend=User.find_by(params[:user])
            if @friend
                respond_to do |format|
                   format.js{render partial: 'users/friend'}
                end
            else
                respond_to do |format|
                    flash.now[:alert] = "Please enter a valid symbol to search"
                    format.js { render partial: 'users/friend' }
                  end
            end
        else
            respond_to do |format|
                flash.now[:alert] = "Please enter a  symbol to search"
                format.js { render partial: 'users/friend' }
              end
        end
    end
end