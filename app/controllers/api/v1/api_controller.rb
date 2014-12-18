module Api::V1
  class ApiController < ApplicationController
    rescue_from Exception, with: :handle_exception

    protected

    def handle_exception(e)
      case e
      when ActiveRecord::RecordNotFound
        render :json => {error: "404 Not Found", message: e.message}, status: 404
      when ActiveRecord::RecordNotUnique
        render :json => {error: "400 Bad Request", message: e.message}, status: 400
      when ActiveRecord::RecordInvalid
        render :json => {error: "422 Unprocessable Entity", message: e.message}, status: 422
      when CanCan::AccessDenied
        render :json => {error: "403 Forbidden", message: e.message}, status: 403
      when ActiveModel::ForbiddenAttributesError
        render :json => {error: "422 Unprocessable Entity", message: e.message}, status: 422
      when ActionController::ParameterMissing
        render json: { error: "400 Bad Request", message: e.message }, status: 400
      else
        render :json => {error: "500 Internal Server Error", message: e.message}, status: 500
      end
    end
  end
end
