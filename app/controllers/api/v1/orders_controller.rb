class Api::V1::OrdersController < Api::ApplicationController

  def index
    if params[:school_id].present?
      orders = Order.where(school_id: params[:school_id])
      orders = orders.map do |order|
        { id: order.id, name: order.name, address: order.address }
      end
      render json: { results: orders }.to_json, status: :ok
    else
      render json: { message: "School id is required." }.to_json, status: :unprocessable_entity
    end
  end

  def create
    if params[:recipients_gifts].present?
      recipients_gifts = JSON.parse(params[:recipients_gifts])
      recipients_qty = []
      recipients_gifts.each do |recipient|
        recipients_qty << recipient[0]
      end
      recipients_qty = recipients_qty.uniq
      if recipients_qty.count < 21 && recipients_gifts.length < 61 && @order = Order.create(school_id: params[:school_id])
        recipients_gifts.each do |t|
          OrderRecipient.create(order_id: @order.id, recipient_id: t[0], gift_type: t[1].to_s)
        end
        message =  "Order successfully created."
        status =  :ok
      else
        message = "There was an error while trying to create the order"
        status =  :unprocessable_entity
      end

      render json: { message: message }.to_json, status: status
    else
      render json: { message: "Recipients-gift array is missing." }.to_json, status: :unprocessable_entity
    end
  end

  def update
    if Order.exists?(params[:id]) && Order.find(params[:id]).status != "ORDER_SHIPPED"
      if params.values_at(:order_status, :send_email).all?(&:present?)
        if Order.find(params[:id]).update(status: params[:order_status], send_email: params[:send_email])
          message = "Order #{params[:id]} was successfully updated."
          status = :ok
        else
          message = "There as an error while trying to update order: #{params[:id]}."
          status = :unprocessable_entity
        end
        render json: { message: message }.to_json, status: status
      else
       render json: { message: "Missing required values." }.to_json, status: :unprocessable_entity
      end
    else
      render json: { message: "Cannot update order with id: #{params[:id]}." }.to_json, status: :unprocessable_entity
    end
  end

  def cancel
    if Order.exists?(params[:order_id]) && Order.find(params[:order_id]).status != "ORDER_SHIPPED"
      if Order.find(params[:order_id]).update(status: "ORDER_CANCELED")
        message = "Order #{params[:order_id]} was successfully canceled."
        status = :ok
      else
        message = "There as an error while trying to cancel order: #{params[:order_id]}."
        status = :ok
      end
      render json: { message: message }.to_json, status: status
    else
      render json: { message: "Cannot cancel order with id: #{params[:order_id]}." }.to_json, status: :unprocessable_entity
    end
  end

  def ship
    if Order.exists?(params[:order_id]) && Order.find(params[:order_id]).status != "ORDER_SHIPPED"
      if Order.find(params[:order_id]).update(status: "ORDER_SHIPPED")
        message = "Order #{params[:order_id]} was successfully shipped."
        status = :ok
      else
        message = "There as an error while trying to update order: #{params[:order_id]}."
        status = :ok
      end
      render json: { message: message }.to_json, status: status
    else
      render json: { message: "Cannot ship order with id: #{params[:order_id]}." }.to_json, status: :unprocessable_entity
    end
  end


end