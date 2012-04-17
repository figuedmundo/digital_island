class UsuariosController < ApplicationController
  before_filter :usuario_actual, only: [:edit, :update]
  
  def index
    @title = "Usuarios"
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
    if @usuario.save
      flash[:success] = "Usuario creado correctamente"
      log_in @usuario
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
    @usuario = Usuario.find_by_id(params[:id])
    if @usuario.update_attributes(params[:usuario])
      flash[:success] = "Datos actualizados"
      log_in @usuario
      redirect_to @usuario
    else
      flash.now[:error] = "Revisa tus datos"
      render :edit
    end
  end
end

private

  def usuario_actual
    @usuario = Usuario.find_by_id(params[:id])
    @title = "Editar perfil de #{@usuario.nombre}"
  end