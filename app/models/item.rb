class Item < ApplicationRecord
  has_one_attached :item_image
  
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :item_image, presence: true
  
  def taxin_price
    (price * 1.1).floor
  end
  
  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpeg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end
end
