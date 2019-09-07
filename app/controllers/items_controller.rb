class ItemsController < ApplicationController
  before_action :set_item, only: [:update, :destroy]

  def sort
    params[:item].each_with_index do |id, index|
      current_user.items.find(id).update(position: index + 1)
    end

    head :ok
  end

  def create
    @item = current_user.items.build(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.update(list_id: current_user.lists.deleted.id)

    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  private
    def set_item
      @item = current_user.items.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :description, :list_id, :completed, :position)
    end
end
