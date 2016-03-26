class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    render json: {message: 'Welcome to Photo Battle!'}
  end
end
