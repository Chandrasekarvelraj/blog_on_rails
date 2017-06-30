class FriendshipsController < ApplicationController
   
	def index
    @users = User.where.not(id: (current_user.friends.pluck(:friend_id) << current_user.id))
  end

  def create
    @friend_id = params[:friend_id]
    if Friendship.add_friend(current_user.id, params[:friend_id]) &&  Friendship.add_friend(params[:friend_id], current_user.id)
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
    @user = current_user.friendships
  end
  
  def destroy
    friendship = current_user.friendships.find(params[:id])
    @friendship_id = params[:id]
    if Friendship.remove_friend(friendship.friend_id, current_user.id) && Friendship.remove_friend(current_user.id, friendship.friend_id)
      respond_to do |format|
        format.html
        format.js {  flash.now[:notice] = "Friend Removed successfully" }
      end
    else
      flash[:error] = "Error occurred when adding friend."
      redirect_to root_url
    end  
  end
end
