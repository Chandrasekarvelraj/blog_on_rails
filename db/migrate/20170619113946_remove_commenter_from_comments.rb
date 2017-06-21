class RemoveCommenterFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :Commenter, :string
  end
end
