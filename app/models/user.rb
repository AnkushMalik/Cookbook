class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_followable
  acts_as_follower
  has_many :recipes
  has_many :favorite_recipes # just the 'relationships'
  has_many :favorites, through: :favorite_recipes, source: :recipe # the actual recipes a user favorites
  #dp
  has_attached_file :image, styles: { medium: "220x220", thumb: "50x50>" }, :default_url => "/assets/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
