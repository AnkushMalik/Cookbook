class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :recipes
  has_many :favorite_recipes # just the 'relationships'
  has_many :favorites, through: :favorite_recipes, source: :recipe # the actual recipes a user favorites

end
