# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < ApplicationController
      before_action :set_bulletin, only: %i[archive to_moderate publish reject]

      def index
        @q = Bulletin.includes(:user, :category).ransack(params[:q])
        @bulletins = @q.result.order(created_at: :desc).page(params[:page])
      end

      def archive
        if @bulletin.may_archive? && @bulletin.archive!
          redirect_to back_path, notice: t('.success')
        else
          redirect_to back_path, status: :unprocessable_entity, alert: t('.error')
        end
      end

      def to_moderate
        if @bulletin.may_moderate? && @bulletin.moderate!
          redirect_to back_path, notice: t('.success')
        else
          redirect_to back_path, status: :unprocessable_entity, alert: t('.error')
        end
      end

      def reject
        if @bulletin.may_reject? && @bulletin.reject!
          redirect_to back_path, notice: t('.success')
        else
          redirect_to back_path, status: :unprocessable_entity, alert: t('.error')
        end
      end

      def publish
        if @bulletin.may_publish? && @bulletin.publish!
          redirect_to back_path, notice: t('.success')
        else
          redirect_to back_path, status: :unprocessable_entity, alert: t('.error')
        end
      end

      private

      def set_bulletin
        @bulletin = Bulletin.includes(:category).find(params[:id])
      end
    end
  end
end
