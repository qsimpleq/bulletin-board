# frozen_string_literal: true

module Web
  class ProfilesController < Web::ApplicationController
    def show
      require_signed_in_user!

      @q = Bulletin.created_by(current_user).includes(:user, :category).ransack(params[:q])
      @bulletins = @q.result.order(created_at: :desc).page(params[:page])
    end
  end
end
