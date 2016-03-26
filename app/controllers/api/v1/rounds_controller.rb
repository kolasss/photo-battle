class Api::V1::RoundsController < ApplicationController
  before_action :set_round

  def show
  end

  private

    def set_round
      @round = Round.find(params[:id])
    end
end
