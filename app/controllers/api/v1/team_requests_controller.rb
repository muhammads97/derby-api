module Api
  module V1
    class TeamRequestsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_request, only: [:show, :update_status]

      def index
        authorize_with_policy JoinRequest
        @requests = policy_scope(JoinRequest, policy_scope_class: TeamRequestPolicy::Scope)
      end

      def show
        authorize_with_policy @request
      end

      def update_status
        authorize_with_policy @request
        authorize params[:status_action], :status_action?, policy_class: TeamRequestPolicy
        @request.send("#{params[:status_action]}!")
      end

      private

      def set_request
        @request = JoinRequest.find(params[:id])
      end

      def authorize_with_policy(record)
        authorize record, policy_class: TeamRequestPolicy
      end
    end
  end
end