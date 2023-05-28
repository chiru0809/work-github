class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer
  
  validates :payment_method, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :total_amount, presence: true
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4}
  
  def subtotal
    item.taxin_price * amount
  end
end
