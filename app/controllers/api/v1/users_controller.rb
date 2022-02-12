module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      before_action :set_user

      def show
        authorize User
      end

      def update
        authorize User
        @user.update!(user_params)
      end

      def leave_team
        @user.leave_team!
      end

      private

      def user_params
        params.require(:user).permit(:name, :phone_number, :password)
      end

      def set_user
        @user = current_user
      end
    end
  end
end