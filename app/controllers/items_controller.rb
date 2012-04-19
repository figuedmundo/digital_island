class ItemsController < ApplicationController
  before_filter :logear_usuario

  def index
  end

  def new
    cliente = Usuario.find(session[:cliente])
    @item = cliente.items.build()
  end

  def show
    @item = Item.find_by_id(params[:id])
  end

  def update
  end

  def destroy
  end
end
