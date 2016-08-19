class ApplicationController < ActionController::API
  before_action :check_login

  private
  def show_error(resource, status)
    render json: resource, status: status, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerialize
  end

  def check_login
    token = request.headers["X-Api-Key"]
    return unless token
    user = User.find_by token: token
    return unless user
    if 5.minutes.ago < user.updated_at
      user.touch
      @current_user = user
    end
  end

  def check_loged_in_user
    head 403 and return unless @current_user
  end

end
