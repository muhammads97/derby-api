Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resource :user, only: %i[update show] do
        post 'leave_team', action: :leave_team, controller: 'users'
      end
      resources :teams, only: %i[index show update create] do
        resources :requests, controller: :team_requests, only: %i[index show update_status] do
          post 'update_status', action: :update_status, controller: :team_requests
        end
        resources :invitations, controller: :team_invitations, only: %i[index show create destroy] 
      end
      resources :requests, controller: :user_requests, only: %i[index show create destroy] do
        post 'update_status', action: :update_status, controller: :user_requests
      end
      resources :invitations, controller: :user_invitations, only: %i[index show] do
        post 'update_status', action: :update_status, controller: :user_invitations
      end
    end
  end
end
