class Api::V1::TargetsController < ApplicationController
  skip_before_action :require_login
  before_action :set_target, except: [:index, :create]

  def index
    @targets = Target.all
  end

  def create
    @target = Target.new(target_params)

    if @target.save
      head :created
    else
      render json: {errors: @target.errors}, status: :unprocessable_entity
    end
  end

  def update
    @target = Target.find(params[:id])

    if @target.update(target_params)
      render :show, status: :ok
    else
      render json: {errors: @target.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if @target.destroy
      head :no_content
    else
      render json: {errors: @target.errors}, status: :unprocessable_entity
    end
  end

  private

    def set_target
      @target = Target.find(params[:id])
    end

    def target_params
      params.require(:target).permit(
        :desc,
        criterion: [
          :color
        ]
      )
    end
end
