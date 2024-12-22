class AdminController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

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
    password = ENV['ADMIN_PASSWORD']
    unless params[:password] == password
      redirect_to root_path, alert: 'You must enter the correct password to access the admin page.'
    end
  end

end