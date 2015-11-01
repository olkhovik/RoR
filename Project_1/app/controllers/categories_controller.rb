class CategoriesController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

def create
    @category = Category.new(category_params)
      if @category.save
        redirect_to @category, notice: 'Category was successfully created.'
      else
        render :new
      end
  end

  def update
      if @category.find(params[:id])
        redirect_to @category, notice: 'Category was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @category.find(params[:id])
      redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end


private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title)
    end
end
