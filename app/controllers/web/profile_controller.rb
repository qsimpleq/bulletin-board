# frozen_string_literal: true

module Web
  class ProfileController < Web::ApplicationController
    def index
      auth_user!
      @q = Bulletin.created_by(current_user).includes(:user, :category).ransack(params[:q])
      @bulletins = @q.result.order(created_at: :desc).page(params[:page])
      @bulletin_columns = %i[name state created_at actions]
      @bulletin_actions = %i[show edit to_moderate archive]

      render 'web/bulletins/index'
    end
  end
end
