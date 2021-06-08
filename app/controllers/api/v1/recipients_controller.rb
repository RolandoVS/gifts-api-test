class Api::V1::RecipientsController < Api::ApplicationController

  def index
    if params[:school_id].present?
      recipients = Recipient.where(school_id: params[:school_id])
      recipients = recipients.map do |recipient|
        { id: recipient.id, name: recipient.name, address: recipient.address }
      end
      render json: { results: recipients }.to_json, status: :ok
    else
      render json: { message: "School id is required." }.to_json, status: :unprocessable_entity
    end
  end

  def create
    if params.values_at(:name, :address, :school_id).all?(&:present?)
      if Recipient.create(name: params[:name], address: params[:address], school_id: params[:school_id])
        message = "Recipient was successfully created."
        status = :created
      else
        message = "There was an error while creating recipient."
        status = :unprocessable_entity
      end
      render json: { message: message }.to_json, status: status
    else
      render json: { message: "School id is required." }.to_json, status: :unprocessable_entity
    end
  end

  def update
    if params.values_at(:name, :address, :school_id).all?(&:present?)
      if Recipient.exists?(params[:id])
        recipient = Recipient.find(params[:id])
        if recipient.update(name: params[:name], address: params[:address])
          message = "Recipient successfully updated."
          status = :ok
        else
          message = "There was an error while trying to update recipient."
          status = :internal_server_error
        end
        render json: { message: message}.to_json, status: status 
      else
        render json: { message: "There is no recipient with id: #{params[:id]}." }.to_json, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if Recipient.exists?(params[:id])
      recipient = Recipient.find(params[:id])
      if recipient.destroy
        message = "Recipient was successfully deleted."
        status = :ok
      else
        message = "There was an error while deleting recipient: #{recipient.name}"
        status = :internal_server_error
      end
      render json: { message: message }.to_json, status: status
    else
      render json: { message: "There is no recipient with id: #{params[:id]}." }.to_json, status: :unprocessable_entity
    end
  end

end
