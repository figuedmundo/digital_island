module SessionsHelper

  def log_in(usuario)
    cookies.permanent[:remember_token] = usuario.remember_token
    current_user = usuario    
  end

  def current_user=(usuario)
    @current_user = usuario
  end

  def current_user
    @current_user ||= usuario_from_remember_token
  end

  def loged_in?
    !current_user.nil?    
  end

  def log_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user?(usuario)
    current_user == usuario
  end

  def logear_usuario
    redirect_to login_path, notice: "Porfor, Ingrese al sistema" unless loged_in?
  end

  def no_cliente
    redirect_to current_user if current_user.cliente?
  end

  private

    def usuario_from_remember_token
      remember_token = cookies[:remember_token]
      Usuario.find_by_remember_token(remember_token) unless remember_token.nil?
    end
end
