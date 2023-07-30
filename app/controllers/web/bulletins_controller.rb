# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :set_bulletin, only: %i[show edit update destroy archive to_moderate]
    before_action :set_categories, only: %i[new edit]

    def index
      @q = Bulletin.published.includes(:user, :category).ransack(params[:q])
      @bulletins = @q.result.order(created_at: :desc).page(params[:page])
    end

    def show; end

    def new
      @bulletin = Bulletin.new
      authorize @bulletin
    end

    def edit
      authorize @bulletin
    end

    def create
      @bulletin = Bulletin.new({ user_id: current_user.id }.merge(bulletin_params))
      authorize @bulletin
      if @bulletin.save
        redirect_to profile_path, notice: t('.success')
      else
        flash[:error] = t('.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize @bulletin
      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('.success')
      else
        flash[:error] = t('.error')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @bulletin
      if @bulletin.destroy
        redirect_to @bulletin, notice: t('.success')
      else
        flash[:error] = t('.error')
        render @bulletin, status: :unprocessable_entity
      end
    end

    def archive
      authorize @bulletin
      if @bulletin.may_archive? && @bulletin.archive!
        redirect_to back_path, notice: t('.success')
      else
        flash[:error] = t('.error')
        redirect_to back_path, status: :unprocessable_entity
      end
    end

    def to_moderate
      authorize @bulletin
      if @bulletin.may_moderate? && @bulletin.moderate!
        redirect_to back_path, notice: t('.success')
      else
        flash[:error] = t('.error')
        redirect_to back_path, status: :unprocessable_entity
      end
    end

    private

    def set_bulletin
      @bulletin = Bulletin.includes(:category).find(params[:id])
    end

    def set_categories
      @categories = Category.where.not(name: nil)
    end

    def bulletin_params
      params.require(:bulletin).permit(%i[category_id description image title])
    end
  end
end
