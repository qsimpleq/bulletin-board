# frozen_string_literal: true

module BulletinsIndex
  def index_prepare
    policy = BulletinPolicy::Scope.new(current_user, Bulletin)
    index_build_policy_options(policy)

    @q = policy.resolve.ransack(params[:q])
    @bulletins = @q.result.page(params[:page]).order(created_at: :desc)
    index_build_columns
    index_build_actions
  end

  def index_build_columns
    @bulletin_columns = %i[name]
    @bulletin_columns << :state if request.path == profile_path || request.path == admin_bulletins_path
    @bulletin_columns << :created_at
    @bulletin_columns << :actions if user_signed_in? && current_user.admin?
  end

  # rubocop:disable Metrics/AbcSize
  def index_build_actions
    @bulletin_actions = %i[]
    return @bulletin_actions unless @bulletin_columns.include?(:actions)

    @bulletin_actions << :show if [profile_path, admin_bulletins_path].include?(request.path)
    @bulletin_actions.push(:edit, :moderate) if request.path == profile_path
    @bulletin_actions.push(:publish, :decline) if request.path == admin_path && current_user.admin?
    @bulletin_actions << :archive
  end

  # rubocop:enable Metrics/AbcSize
  def index_build_policy_options(policy)
    policy.options = {
      admin_bulletins_path:,
      admin_path:,
      bulletins_path:,
      current_path: request.path,
      profile_path:
    }
  end
end
