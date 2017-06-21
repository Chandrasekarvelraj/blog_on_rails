class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates	:title, {:presence => true, :uniqueness => true, :length => {:minimum =>2}}
	validates   :content, :presence => true
end
