class Api::V1::ApiBaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :authenticate_token
  before_action :set_json_format

  attr_reader :current_user

  private

  def auth_token
    @auth_token ||= request.headers["Authorization"]&.split(" ")&.last
  end

  def authenticate_token
    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find(payload[:sub])
  rescue JsonWebToken::JsonWebTokenError => e
    render json: { errors: [e.message] }, status: :unauthorized
  end

  def set_json_format
    request.format = :json
  end
end
