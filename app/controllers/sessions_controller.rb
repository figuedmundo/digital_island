class SessionsController < ApplicationController

  def new
    @title = "Log in"
  end

  def create
    user = Usuario.find_by_email(params[:email])
    if user.nil?
      @title = "Log in"
      params[:email] = nil
      flash.now[:error] = "Email no valido, porfavor reviselo"
      render :new
    elsif user.authenticate(params[:password])
      flash[:success] = "Bienvenido"
      log_in user
      redirect_to user
    else
      @title = "Log in"
      flash.now[:error] = "Password no valido"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
