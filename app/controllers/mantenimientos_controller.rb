class MantenimientosController < ApplicationController
  def index
    reporte = params[:reporte]
    @coleccion = Mantenimiento.where(reporte: reporte)
    render json: @coleccion
  end

end
