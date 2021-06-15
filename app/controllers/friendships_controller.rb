class FriendshipsController < ApplicationController

    def create 
        friend=User.check_db(params[:first_name], params[:last_name])
        if friend.blank?   
            friend= User.find_by(params[:first_name],params[:last_name])
            friend.save
        end
        @friendship= Friendships.create(user: current_user, friend: friend)
        flash[:notice]="Stock #{friend.first_name} was successfully added to your friends"
        redirect_to my_friends_path
    end
    def destroy
        friend=User.find(params[:id])
        friendship=Friendship.where(user_id: current_user.id, friend_id: friend.id).first
        friendship.destroy
        flash[:notice]="#{friend.id} was successfuly removed from friends"
        redirect_to my_friends_path
    end
end