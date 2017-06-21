class RemoveCommenterFromCommentsTable < ActiveRecord::Migration
  def change
  	remove_column :comments, :commenter
  end
end
