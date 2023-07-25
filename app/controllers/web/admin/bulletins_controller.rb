# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::ApplicationController
      include BulletinsIndex

      def index
        index_prepare

        render 'web/admin/index'
      end
    end
  end
end
