# frozen_string_literal: true

module Web
  class ProfileController < Web::ApplicationController
    include BulletinsCommon

    def index
      index_prepare

      render 'web/bulletins/index'
    end
  end
end
