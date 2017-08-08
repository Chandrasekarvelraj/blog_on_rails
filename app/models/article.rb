require 'elasticsearch/model'

class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates   :title, {:presence => true, :uniqueness => true, :length => {:minimum =>2}}
  validates   :content, :presence => true

  #include Elasticsearch::Model
  #include Elasticsearch::Model::Callbacks
end
#Article.import force: true