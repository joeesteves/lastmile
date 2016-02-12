class MantenimientosController < ApplicationController
  def index
    reporte = params[:reporte]
    @coleccion = Mantenimiento.detalle(reporte, excluded: ['maquina'])
    render json: @coleccion
  end

end
