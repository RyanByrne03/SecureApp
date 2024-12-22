class AdminController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'password123'

  def index
    @todos = Todo.all
    log_file = Rails.root.join('log', "#{Rails.env}.log")
    @logs = File.readlines(log_file).last(50) if File.exist?(log_file)
  end

  def destroy
    @todo = Todo.find_by(id: params[:id])
    if @todo
      @todo.destroy!
      respond_to do |format|
        format.html { redirect_to admin_path, notice: 'To-Do was successfully deleted.' }
        format.js 
      end
    else
      respond_to do |format|
        format.html { redirect_to admin_path, alert: 'To-Do not found.' }
        format.json { render json: { error: 'To-Do not found.' }, status: :not_found }
      end
    end
  end

  public

  def authenticate_admin
    # Check if the password is correct
    password = 'password123'
    unless params[:password] == 'password123'
      redirect_to root_path, alert: 'You must enter the correct password to access the admin page.'
      render plain: "The correct password is #{password}. Please try again."
    end
  end

end