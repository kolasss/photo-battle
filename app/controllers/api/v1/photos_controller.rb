class Api::V1::PhotosController < ApplicationController
  # before_action :set_round

  # def show
  # end

  def create
    @round = Round.find(params[:round_id])
    @photo = @round.photos.new user: current_user, file: params[:photo]

    if @photo.save
      @round.find_winner
      render :show, status: :created
    else
      render json: {errors: @photo.errors}, status: :unprocessable_entity
    end
  end

  private

    # def set_round
    #   @round = Round.find(params[:id])
    # end

    # def photo_params
    #   params.require(:photo).permit(
    #     :file
    #   )
    # end
end
