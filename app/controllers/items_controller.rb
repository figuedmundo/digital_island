class ItemsController < ApplicationController
  before_filter :logear_usuario
  before_filter :no_cliente, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :solo_admin, only: :destroy

  def index
    @items = Item.all
  end

  def new
    @cliente = Usuario.find(session[:cliente])
    @item = @cliente.items.build()
  end

  def create
    @cliente = Usuario.find(session[:cliente])
    @item = @cliente.items.build(params[:item])
    @item.ac = @item.ac.to_i
    @item.total = @item.total.to_i
    @item.estado = 'recibido'
    if @item.save
      flash[:notice] = "item creado"
      redirect_to @cliente
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
    @item = Item.find_by_id(params[:id])
    @item.ac = @item.ac.to_i
    @item.total = @item.total.to_i
    if @item.update_attributes(params[:item])
      flash[:success] = "Item actualizado"
      redirect_to @item
    else
      flash.now[:error] = "#{params}"
      render :edit
    end
  end

  def destroy
    @item = Item.find_by_id(params[:id])
    @item.destroy
    flash[:success] = "Item Deleted"
    redirect_to items_path
  end
end

private
  
  def solo_admin
    redirect_to items_path , notice: "No no no!" unless current_user.admin?
  end