class LaboresController < ApplicationController
  def index
    reporte = params[:reporte]
    @coleccion = Labor.where(reporte: reporte)
    render json: @coleccion
  end

end
