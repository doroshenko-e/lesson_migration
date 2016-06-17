class UsersController < ApplicationController
  
  def index
  
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
     respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
      end
    end
  end


  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
    end  
  end

  #def delete
  #end

end
