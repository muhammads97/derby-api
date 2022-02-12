module Api
  module V1
    class TeamInvitationsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_invitation, only: [:show, :destroy]

      def index
        authorize_with_policy Invitation
        @invitations = policy_scope(Invitation, policy_scope_class: TeamInvitationPolicy::Scope)
      end

      def show
        authorize_with_policy @invitation
      end

      def create
        authorize_with_policy Invitation
        @invitation = current_user.team.invitations.create!(invitation_params)
      end

      def destroy
        authorize_with_policy @invitation
        @invitation.destroy!
        render "destroyed", status: :success
      end

      private

      def set_invitation
        @invitation = Invitation.find(params[:id])
      end 

      def invitation_params
        params.require(:invitation).permit(:player_id, :message)
      end

      def authorize_with_policy(record)
        authorize record, policy_class: TeamInvitationPolicy
      end

    end
  end
end