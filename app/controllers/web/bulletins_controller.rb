# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    include BulletinsIndex

    after_action :check_policy, only: %i[show new create edit update destroy archive decline moderate publish]
    before_action :set_bulletin, only: %i[show edit update destroy]
    before_action :set_state, only: %i[archive decline moderate publish]
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

    def decline; end

    def moderate; end

    def publish; end

    private

    def check_policy
      authorize @bulletin
    end

    def bulletin_params
      params.require(:bulletin).permit(%i[category_id description image title])
    end

    def index_filter
      result = []
      if request.path == profile_path
        result.push(:created_by, current_user)
      elsif request.path == admin_path
        result << :under_moderation
      elsif request.path == admin_bulletins_path
        result << :all
      else
        result << :published
      end
      result
    end

    def set_bulletin
      @bulletin = Bulletin.includes(:category).find(params[:id])
    end

    def set_categories
      @categories = Category.where.not(name: nil)
    end

    def set_state
      set_bulletin
      if @bulletin&.method("may_#{action_name}?") && @bulletin.aasm.fire!(:"#{action_name}")
        redirect_to profile_path, notice: t('.success')
      else
        flash[:error] = t('.error')
        render profile_path
      end
    end
  end
end
