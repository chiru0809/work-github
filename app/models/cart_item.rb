class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  def subtotal
    item.taxin_price * amount
  end

end
