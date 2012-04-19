class UsuariosController < ApplicationController
  before_filter :logear_usuario
  # before_filter :usuario_actual, only: [:edit, :update]
  before_filter :usuario_correcto, only: [:show ,:edit, :update]
  before_filter :registro_clientes, only: [:new, :create]
  before_filter :no_cliente, only: :index
  before_filter :admin_user, only: :destroy

  
  
  def index
    @title = "Usuarios"
    @usuarios = Usuario.all
  end

  def new
    @title = "Registro"
    @usuario = Usuario.new()
  end

  def show
    # @usuario = Usuario.find(params[:id])
    @title = @usuario.nombre
    @items = @usuario.items
    session[:cliente] = @usuario.id
  end

  def create
    @usuario = Usuario.new(params[:usuario])
    @usuario.password = DEFAULT_PASSWORD
    @usuario.password_confirmation = DEFAULT_PASSWORD
    @usuario.created_by = current_user.nombre
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

  def destroy
    Usuario.find(params[:id]).destroy
    flash[:success] = "usuario eliminado"
    redirect_to root_path
  end
end

private

  # def usuario_actual
  #   @usuario = Usuario.find_by_id(params[:id])
  #   @title = "Editar perfil de #{@usuario.nombre}"
  # end



  def registro_clientes 
    redirect_to root_path, notice: "Acceso restringido" if current_user.cliente?
  end

  def usuario_correcto
    @usuario = Usuario.find_by_id(params[:id])
    @title = "Editar perfil de #{@usuario.nombre}"
    if current_user.cliente?
      redirect_to(root_path) unless current_user?(@usuario)
    end
  end

  def no_cliente
    redirect_to current_user if current_user.cliente?
  end

  def admin_user
    redirect_to root_path unless current_user.admin? 
  end