class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  def self.add_friend(first_id, second_id)
    begin
      self.transaction do 
        self.create(:user_id => first_id, :friend_id => second_id)
        self.create(:user_id => second_id, :friend_id => first_id)
      end
      return true
    rescue ActiveRecord::RecordInvalid
      return false
    end
  end

  def self.remove_friend(first_id, second_id)
    begin
      self.transaction do 
        self.where(:user_id => first_id, :friend_id => second_id).destroy_all
        self.where(:user_id => second_id, :friend_id => first_id).destroy_all
      end
      return true
    rescue ActiveRecord::RecordInvalid
      return false
    end
  end

end
