module Api
  module V1
    class TeamsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_user
      before_action :set_team, only: [:show, :update]

      def index
        authorize Team
        @pagination, @teams = paginate(policy_scope(Team.all))
      end

      def show
        authorize @team
      end

      def create
        authorize Team
        ActiveRecord::Base.transaction do
          @team = Team.new(team_create_params)
          @team.captain = @user
          @team.save!
          @user.update!(team: @team)
        end
      end

      def update
        authorize @team
        @team.update!(team_update_params)
      end

      private

      def set_user
        @user = current_user
      end

      def set_team
        @team = Team.find(params[:id])
      end

      def team_create_params
        params.require(:team).permit(:name)
      end

      def team_update_params
        params.require(:team).permit(:name, :captain_id)
      end
    end
  end
end