# frozen_string_literal: true

module Web
  class ProfileController < Web::ApplicationController
    before_action :require_signed_in_user!, only: :index
    def index
      @q = Bulletin.created_by(current_user).includes(:user, :category).ransack(params[:q])
      @bulletins = @q.result.order(created_at: :desc).page(params[:page])

      render 'web/bulletins/index'
    end
  end
end
