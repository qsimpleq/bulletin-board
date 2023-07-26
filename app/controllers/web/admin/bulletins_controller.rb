# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::ApplicationController
      include BulletinsCommon
      after_action :check_policy, only: %i[archive moderate publish reject]
      before_action :set_state, only: %i[archive moderate publish reject]

      def index
        index_prepare

        render 'web/admin/index'
      end

      def archive; end

      def moderate; end

      def reject; end

      def publish; end
    end
  end
end
