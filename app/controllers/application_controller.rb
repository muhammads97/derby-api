class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ExceptionHandler
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone_number, :role])
  end

  def paginate(scope, default_per_page = 10)
    if params[:page] == "-1" && scope.count > 0
      collection = scope.page(1).per(scope.count)
    else
      collection = scope.page(params[:page]).per((params[:per_page] || default_per_page).to_i)
    end
        
    return [{
      current:  collection.current_page,
      previous: collection.prev_page,
      next:     collection.next_page,
      per_page: collection.limit_value,
      pages:    collection.total_pages,
      count:    collection.total_count
    }, collection]
  end
end
