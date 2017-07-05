class User < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "200x200#", thumb: "50x50#" }, default_url: "/images/:style/missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates   :name, {:presence => true, :uniqueness => true, :length => {:minimum =>2}}
  
  devise :database_authenticatable, :async, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
