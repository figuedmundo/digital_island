class UsuariosController < ApplicationController
  
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
      redirect_to @usuario
    else
      @title = "Registro"
      flash.now[:error] = "Revisa los datos"
      render :new
    end
  end
end
