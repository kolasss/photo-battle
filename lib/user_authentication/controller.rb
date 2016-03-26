# аутентификация сделана частично
# по туториалу http://adamalbrecht.com/2015/07/20/authentication-using-json-web-tokens-using-rails-and-react/
# метод user_not_authenticated определен в application_controller


module UserAuthentication
  module Controller
    extend ActiveSupport::Concern

    private

      def require_login
        if !logged_in?
          user_not_authenticated
        end
      end

      def logged_in?
        !!current_user
      end

      def current_user
        unless defined?(@current_user)
          login_from_token
        end
        @current_user
      end

      # def current_auth_by_token
      #   current_user.authentications.find decoded_auth_token[:auth_id]
      # end

      def login_from_token
        if auth_id = request.headers['Authorization']
          @current_user = ::User.find auth_id
        else
          user_not_authenticated
        end
      rescue
        user_not_authenticated
      end
  end
end
