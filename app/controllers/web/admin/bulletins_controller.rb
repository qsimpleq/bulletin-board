# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      before_action :set_bulletin, only: %i[archive to_moderate publish reject]

      def index
        @q = Bulletin.includes(:user, :category).ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc).page(params[:page])

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
        if @bulletin.may_moderate? && @bulletin.aasm.fire!(:moderate)
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
