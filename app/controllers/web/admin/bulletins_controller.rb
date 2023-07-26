# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::ApplicationController
      include BulletinsCommon
      after_action :check_policy, only: %i[publish reject]
      before_action :set_state, only: %i[publish reject]

      def index
        index_prepare

        render 'web/admin/index'
      end

      def reject; end

      def publish; end
    end
  end
end
