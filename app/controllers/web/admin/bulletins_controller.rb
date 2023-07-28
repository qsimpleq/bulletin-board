# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      # before_action :
      before_action :set_bulletin, only: %i[archive to_moderate publish reject]

      def index
        @q = Bulletin.includes(:user, :category).ransack(params[:q])
        @bulletins = @q.result.page(params[:page]).order(created_at: :desc)
        @bulletin_columns = %i[name state created_at actions]
        @bulletin_actions = %i[show archive]

        render 'web/admin/index'
      end

      def under_moderation
        raise Pundit::NotAuthorizedError, t('pundit.default_admin') unless current_user&.admin?

        @q = Bulletin.under_moderation.includes(:user, :category).ransack(params[:q])
        @bulletins = @q.result.page(params[:page]).order(created_at: :desc)
        @bulletin_columns = %i[name created_at actions]
        @bulletin_actions = %i[publish reject archive]

        render 'web/admin/index'
      end

      def archive
        authorize @bulletin
        if @bulletin.may_archive? && @bulletin.aasm.fire!(:archive)
          redirect_to back_path, notice: t('.success')
        else
          flash[:error] = t('.error')
          redirect_to back_path, status: :unprocessable_entity
        end
      end

      def to_moderate
        authorize @bulletin
        if @bulletin.may_to_moderate? && @bulletin.aasm.fire!(:to_moderate)
          redirect_to back_path, notice: t('.success')
        else
          flash[:error] = t('.error')
          redirect_to back_path, status: :unprocessable_entity
        end
      end

      def reject
        authorize @bulletin
        if @bulletin.may_reject? && @bulletin.aasm.fire!(:reject)
          redirect_to back_path, notice: t('.success')
        else
          flash[:error] = t('.error')
          redirect_to back_path, status: :unprocessable_entity
        end
      end

      def publish
        authorize @bulletin
        if @bulletin.may_publish? && @bulletin.aasm.fire!(:publish)
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
    end
  end
end
