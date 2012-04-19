class ItemsController < ApplicationController
  before_filter :logear_usuario

  def index
    @items = Item.all
  end

  def new
    cliente = Usuario.find(session[:cliente])
    @item = cliente.items.build()
  end

  def create
    cliente = Usuario.find(session[:cliente])
    @item = cliente.items.build(params[:item])
    @item.estado = 'recibido'
    if @item.save
      flash[:notice] = "item creado"
      redirect_to usuario_path(cliente)
    else
      flash.now[:error] = "#{params}"
      render :new
    end
  end

  def show
    @item = Item.find_by_id(params[:id])
  end

  def edit
    @item = Item.find_by_id(params[:id])
  end

  def update

  end

  def destroy
  end
end
