class OrdersController < ApplicationController
  def index
    session[:employee_role] = nil
    session[:edit_category] = nil
    render "index", locals: { status: params[:status].present? ? params[:status] : "all",
                              invoice_id: params[:invoice] ? params[:invoice] : nil }
  end

  def create
    new_order = Order.cart_to_order(params[:cart_id])
    redirect_to order_items_path(cart_id: params[:cart_id], order_id: new_order.id)
  end
end
