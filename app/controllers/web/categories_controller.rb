# frozen_string_literal: true

module Web
  class CategoriesController < Web::ApplicationController
    before_action :set_category, only: %i[show edit update destroy]

    def index
      @categories = Category.where.not(name: nil)
      @category_columns = %i[id name]
      @category_columns << :actions if user_signed_in?
    end

    def new
      @category = Category.new
    end

    def edit; end

    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to categories_path, notice: t('.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @category.update(category_params)
        redirect_to categories_path, notice: t('.success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @category.destroy
        redirect_to categories_path, notice: t('.success')
      else
        render @category, status: :unprocessable_entity
      end
    end

    private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
