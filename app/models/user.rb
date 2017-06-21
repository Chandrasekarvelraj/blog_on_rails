class User < ActiveRecord::Base


	has_attached_file :avatar, styles: { medium: "200x200>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


	validates	:name, {:presence => true, :uniqueness => true, :length => {:minimum =>2}}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :lockable
has_many :articles, dependent: :destroy
has_many :comments, dependent: :destroy
end
