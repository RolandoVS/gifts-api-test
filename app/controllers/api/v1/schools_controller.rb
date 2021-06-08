class Api::V1::SchoolsController < Api::ApplicationController
  def index
    schools = School.all
    schools = schools.map do |school|
      { id: school.id, name: school.name }
    end
    
    render json: { results: schools }.to_json, status: :ok
  end

  def create
    if params[:name].present? && params[:address].present?
      if @school = School.create(name: params[:name], address: params[:address])
        message = "School: #{@school.name} created"
        status = :created
      else
        message = "There was an error while trying to create school"
        status = :internal_server_error
      end
      render json: { message: message }.to_json, status: status
    else
      render json: { message: "School's name and adress are required." }.to_json, status: :unprocessable_entity
    end
  end

  def update
    if School.exists?(params[:id])
      school = School.find(params[:id])
      if params[:name].present? && params[:address].present?
        if school.update(name: params[:name], address: params[:address])
          message = "School successfully updated."
          status = :ok
        else
          message = "There was an error while trying to update school."
          status = :internal_server_error
        end
      else
          message = "School's name and address are required."
          status = :bad_request
      end
      render json: { message: message}.to_json, status: status 
    else
      render json: { message: "There is no school with id: #{params[:id]}." }.to_json, status: :unprocessable_entity
    end
  end

  def destroy
    if School.exists?(params[:id])
      school = School.find(params[:id])
      if school.destroy
        message = "School was successfully deleted."
        status = :ok
      else
        message = "There was an error while deleting school: #{school.name}"
        status = :internal_server_error
      end
      render json: { message: message }.to_json, status: status
    else
      render json: { message: "There is no school with id: #{params[:id]}." }.to_json, status: :unprocessable_entity
    end
  end

end
