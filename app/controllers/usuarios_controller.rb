class UsuariosController < ApplicationController
  before_filter :logear_usuario
  # before_filter :usuario_actual, only: [:edit, :update]
  before_filter :usuario_correcto, only: [:show ,:edit, :update]
  before_filter :registro_clientes, only: [:new, :create]
  before_filter :no_cliente, only: :index
  # before_filter :privilegios_show, only: :show

  
  
  def index
    @title = "Usuarios"
    @usuarios = Usuario.all
  end

  def new
    @title = "Registro"
    @usuario = Usuario.new()
  end

  def show
    @usuario = Usuario.find(params[:id])
    @title = @usuario.nombre
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    @usuario.password = DEFAULT_PASSWORD
    @usuario.password_confirmation = DEFAULT_PASSWORD
    if @usuario.save
      flash[:success] = "Usuario creado correctamente"
      redirect_to @usuario
    else
      @title = "Registro"
      flash.now[:error] = "Revisa los datos"
      render :new
    end
  end

  def edit
    # @usuario = Usuario.find_by_id(params[:id])
    # @title = "Editar perfil de #{@usuario.nombre}"
  end

  def update
    # @usuario = Usuario.find_by_id(params[:id])
    # @usuario.nombre = params[:usuario][:nombre]
    # @usuario.apellido = params[:usuario][:apellido]
    # @usuario.email = params[:usuario][:email]
    # @usuario.telefono = params[:usuario][:telefono]

    if @usuario.update_attributes(params[:usuario])
      flash[:success] = "Datos actualizados"
      if current_user.cliente?
        log_in @usuario
        redirect_to @usuario
      else
        redirect_to root_path
      end
    else
      flash.now[:error] = "#{params[:usuario]}"
      render :edit
    end

  end
end

private

  # def usuario_actual
  #   @usuario = Usuario.find_by_id(params[:id])
  #   @title = "Editar perfil de #{@usuario.nombre}"
  # end

  def logear_usuario
    redirect_to login_path, notice: "Porfor, Ingrese al sistema" unless loged_in?
  end

  def registro_clientes 
    redirect_to root_path, notice: "Acceso restringido" if current_user.cliente?
  end

  def usuario_correcto
    @usuario = Usuario.find_by_id(params[:id])
    @title = "Editar perfil de #{@usuario.nombre}"
    if current_user.cliente?
      redirect_to(current_user) unless current_user?(@usuario)
    end
  end

  def no_cliente
    redirect_to current_user if current_user.cliente?
  end



  # def privilegios_show
  #   redirect_to root_path if !current_user?(@usuario) || current_user.cliente? 
  # end