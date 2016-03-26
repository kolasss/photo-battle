class Api::V1::BattlesController < ApplicationController
  before_action :set_battle, except: [:create]

  # def index
  #   @battles = User.all
  # end

  def show
  end

  def create
    @battle = Battle.find_or_create current_user

    render :show, status: :created
  end

  # def update
  #   @battle = User.find(params[:id])

  #   if @battle.update(battle_params)
  #     render :show, status: :ok
  #   else
  #     render json: {errors: @battle.errors}, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   if @battle.destroy
  #     head :no_content
  #   else
  #     render json: {errors: @battle.errors}, status: :unprocessable_entity
  #   end
  # end

  # def rounds
  #   @rounds = @battle.rounds
  # end

  private

    def set_battle
      @battle = Battle.find(params[:id])
    end

    # def battle_params
    #   params.require(:battle).permit(
    #     :name
    #   )
    # end
end
