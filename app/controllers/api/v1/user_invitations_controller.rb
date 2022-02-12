module Api
  module V1
    class UserInvitationsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_invitation, only: [:show, :update_status]

      def index
        authorize_with_policy Invitation
        @invitations = policy_scope(Invitation, policy_scope_class: UserInvitationPolicy)
      end

      def show
        authorize_with_policy @invitation
      end

      def update_status
        authorize_with_policy @invitation
        authorize params[:status_action], :status_action?, policy_class: UserRequestPolicy
        @invitation.send("#{params[:status_action]}!")
      end


      private
      def set_invitation
        @invitation = Invitation.find(params[:id])
      end

      def authorize_with_policy(record)
        authorize record, policy_class: UserRequestPolicy
      end
    end
  end
end