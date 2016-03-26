class ApplicationController < ActionController::API
  include UserAuthentication::Controller

  before_action :require_login # проверка логина юзера

  private

    # не залогинен
    def user_not_authenticated
      head :unauthorized
    end
end
