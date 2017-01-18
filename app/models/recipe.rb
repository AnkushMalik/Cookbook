class Recipe < ActiveRecord::Base

  acts_as_votable
  belongs_to :user
  has_many :ingredients
  has_many :directions
  has_many :comments
  accepts_nested_attributes_for :ingredients,
    															reject_if: proc { |attributes| attributes['name'].blank? },
    															allow_destroy: true
   	accepts_nested_attributes_for :directions,
    															reject_if: proc { |attributes| attributes['step'].blank? },
    															allow_destroy: true
  validates :title,:description,:tag_list,:image,presence: true
  acts_as_taggable
  has_attached_file :image, styles: { medium: "370x310#", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_many :favorite_recipes # just the 'relationships'
  has_many :favorited_by, through: :favorite_recipes, source: :user # the actual users favoriting a recipe



  searchable do
    text :title,:description
  end
end
