# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    include BulletinsCommon

    after_action :check_policy, only: %i[show new create edit update destroy archive moderate]
    before_action :set_bulletin, only: %i[show edit update destroy]
    before_action :set_state, only: %i[archive moderate]
    before_action :set_categories, only: %i[new edit]

    def index
      index_prepare
    end

    def show; end

    def new
      @bulletin = Bulletin.new
    end

    def edit; end

    def create
      @bulletin = Bulletin.new({ user_id: current_user.id }.merge(bulletin_params))

      if @bulletin.save
        redirect_to profile_path, notice: t('.success')
      else
        flash[:error] = t('.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('.success')
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

    def archive; end

    def moderate; end

    private

    def set_categories
      @categories = Category.where.not(name: nil)
    end
  end
end
