class ApplicationController < ActionController::Base

  include DeviseTokenAuth::Concerns::SetUserByToken

  include ApplicationHelper
  include ResponseHelper

  before_action :log_request
  before_action :authenticate_user!, :set_current_user
  skip_before_action :authenticate_user!, :set_current_user if ENV['NO_AUTH'].eql?('Y')

  after_action :reset_current_user

  # after_action :log_response

  def set_current_user
    return nil unless request.headers['uid'].present? # TODO remove this extra check
    access_token = request.headers['access_token'].presence || request.headers['access-token']
    current_user_data = {
        'uid' => request.headers['uid'],
        'access_token' => access_token,
        'client' => request.headers['client']
    }
    return true unless current_user.present?
    current_user_data.merge!(current_user.as_json)
    Thread.current[:current_user] = current_user_data
  end

  def reset_current_user
    Thread.current[:current_user] = nil
  end

  rescue_from Exception do |e|
    Thread.current[:current_user] = nil

    generate_server_error_response(e, request.request_id, params)
  end

  def log_request
    Rails.logger.info "Headers :- uid: #{request.headers['uid']}, client: #{request.headers['client']}, access-token: #{request.headers['access-token']}, x_client_id: #{request.headers['HTTP_X_CLIENT_ID']},x_request_id: #{request.headers['HTTP_X_REQUEST_ID']}"
  end

  def log_response
     Rails.logger.debug "Response :- #{response.body}"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :user_name, :password, :password_confirmation, :phone_number, ,:gender, :roles)}
  end

end
