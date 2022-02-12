module Api
  module V1
    class UserRequestsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_request, only: [:show, :destroy]

      def index
        authorize_with_policy JoinRequest
        @requests = policy_scope(JoinRequest, policy_scope_class: UserRequestPolicy::Scope)
      end

      def show
        authorize_with_policy @request
      end

      def create
        authorize_with_policy JoinRequest
        @request = current_user.requests.create!(request_params)
      end

      def update_status
        authorize_with_policy @request
        authorize params[:status_action], :status_action?, policy_class: UserRequestPolicy
        @request.send("#{params[:status_action]}!")
      end

      def destroy
        authorize_with_policy @request
        @request.destroy!
        render "destroyed", status: :success
      end

      private

      def set_request
        @request = JoinRequest.find(params[:id])
      end

      def request_params
        params.require(:request).permit(:team_id, :message)
      end

      def authorize_with_policy(record)
        authorize record, policy_class: UserRequestPolicy
      end
    end
  end
end