class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  def self.add_friend(first_id, second_id)
    friend = self.new(:user_id => first_id, :friend_id => second_id)
    true if friend.save rescue false
  end

  def self.remove_friend(first_id, second_id)
    friend = self.find_by user_id: first_id, friend_id: second_id
    true if friend.destroy rescue false
  end

end
