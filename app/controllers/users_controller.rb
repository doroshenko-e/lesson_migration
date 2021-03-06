# user class
class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to users_path, notice: 'User created.' }
        format.js
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    @user = current_user
  end

  def show
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
    end
  end

  # def delete
  # end
end
