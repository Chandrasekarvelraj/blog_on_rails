class FriendshipsController < ApplicationController
   
	def index
    @users = User.where.not(id: (current_user.friends.pluck(:friend_id) << current_user.id))
  end

  def create
    friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    @friend_id = params[:friend_id]
    friend = Friendship.new
    friend.user_id = params[:friend_id]
    friend.friend_id = current_user.id
    if friendship.save && friend.save
      respond_to do |format|
        format.html
        format.js {  flash.now[:notice] = "Added Friend Successfully" }
      end
    else
      flash[:error] = "Error occurred when adding friend."
      redirect_to root_url
    end
  end

  def show
  end
  
  def destroy
    friendship = current_user.friendships.find(params[:id])
    @friendship_id = params[:id]
    friend = Friendship.find_by user_id: friendship.friend_id, friend_id: current_user.id
    friend.destroy
    friendship.destroy
      respond_to do |format|
        format.html
        format.js {  flash.now[:notice] = "Friend Removed successfully" }
      end 
  end
end
