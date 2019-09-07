class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update]

  def index
    @lists = current_user.lists.without_deleted.order(name: :asc)
  end

  def show
    @items = @list.items
  end

  def new
    list = current_user.lists.create(name: "Untitled")
    redirect_to list_path(list)
  end

  def create
    @list = current_user.lists.build(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @list.destroy
  #
  #   respond_to do |format|
  #     format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_list
      @list = current_user.lists.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:name)
    end
end
