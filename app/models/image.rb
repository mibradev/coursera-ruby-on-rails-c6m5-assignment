class Image < ActiveRecord::Base
  include Protectable
  attr_accessor :image_content

  has_one :user
  has_many :thing_images, inverse_of: :image, dependent: :destroy
  has_many :things, through: :thing_images

  scope :except_user_images, -> { joins("LEFT OUTER JOIN users ON images.id = users.image_id").where("users.image_id": nil) }

  def basename
    caption || "image-#{id}"
  end
end
