# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :authenticate_user!, only: %i[create destroy edit new update]
    before_action :set_bulletin, only: %i[show edit update destroy]
    before_action :set_categories, only: %i[new create edit]

    def index
      @bulletins = Bulletin.includes(:category).order(created_at: :desc)
    end

    def show; end

    def new
      @bulletin = Bulletin.new
    end

    def edit; end

    def create
      @bulletin = Bulletin.new({ creator_id: current_user.id }.merge(bulletin_params))

      if @bulletin.save
        redirect_to bulletins_path, notice: t('.success')
      else
        flash[:error] = t('.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @bulletin.update(bulletin_params)
        redirect_to @bulletin, notice: t('.success')
      else
        flash[:error] = t('.error')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @bulletin.destroy
        redirect_to @bulletin, notice: t('.success')
      else
        flash[:error] = t('.error')
        render @bulletin, status: :unprocessable_entity
      end
    end

    private

    def set_bulletin
      @bulletin = Bulletin.includes(:category).find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(%i[category_id description image title])
    end

    def set_categories
      @categories = Category.where.not(name: nil)
    end
  end
end
