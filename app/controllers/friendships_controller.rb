class FriendshipsController < ApplicationController
    def create 
        friend=User.check_db(params[:first_name])
        if friend.blank?   
            friend= User.find_by(first_name: params[:first_name])
            friend.save
        end
        @friendship= Friendship.create(user: current_user, friend: friend)
        flash[:notice]="User #{friend.first_name} was successfully added to your friends"
        redirect_to my_friends_path
    end
    def destroy
        friend=User.find(params[:id])
        friendship=Friendship.where(user_id: current_user.id, friend_id: friend.id).first
        friendship.destroy
        flash[:notice]="Successfuly removed from friends"
        redirect_to my_friends_path
    end
end