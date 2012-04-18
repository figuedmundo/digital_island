class SessionsController < ApplicationController

  def new
    @title = "Log in"
  end

  def create
    usuario = Usuario.find_by_email(params[:email])
    if usuario.nil?
      @title = "Log in"
      params[:email] = nil
      flash.now[:error] = "Email no valido, porfavor reviselo"
      render :new
    elsif usuario.authenticate(params[:password])
      log_in usuario
      if params[:password] == DEFAULT_PASSWORD
        flash[:notice] = "Revisa tus datos"
        redirect_to edit_usuario_path(usuario)
      else
        flash[:success] = "Bienvenido"
        redirect_to usuario_rol(usuario)
      end
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

private
  
  def usuario_rol(user)
    (user.admin? || user.tecnico? || user.vendedor?) ? usuarios_path : user
  end