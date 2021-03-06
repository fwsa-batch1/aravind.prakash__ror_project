class CartItemsController < ApplicationController
  def create
    item = MenuItem.find(params[:item_id])
    item_name = item.name
    item_price = item.price

    CartItem.create!(
      cart_id: params[:cart_id],
      menu_item_id: params[:item_id],
      menu_item_name: item_name,
      menu_item_price: item_price,
      quantity: 1,
    )
    redirect_to menu_index_path
  end

  def update
    user_cart = Cart.find_by(user_id: @current_user.id)
    item = user_cart.cart_items.find_by(menu_item_id: params[:item_id])
    if params[:quantity] == "increase"
      item.quantity = item.quantity + 1
      item.save!
    elsif params[:quantity] == "decrease"
      if item != nil
        if item.quantity > 1
          item.quantity = item.quantity - 1
          item.save!
        else
          item.destroy
        end
      end
    end
    redirect_to menu_index_path
  end

  def destroy
    CartItem.where(cart_id: params[:cart_id]).destroy_all
    redirect_to invoices_path(order_id: params[:order_id])
  end
end
