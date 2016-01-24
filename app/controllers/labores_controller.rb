class LaboresController < ApplicationController
  def index
    @labores = Labor.all
    render json: @labores
  end
end
