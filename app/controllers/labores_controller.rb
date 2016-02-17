class LaboresController < ApplicationController
  def index
    reporte = params[:reporte]
    @coleccion = @coleccion = Labor.por_actividad(reporte)
    render json: @coleccion
  end

end
