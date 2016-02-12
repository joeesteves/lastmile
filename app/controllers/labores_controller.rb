class LaboresController < ApplicationController
  def index
    reporte = params[:reporte]
    @coleccion = @coleccion = Labor.detalle(reporte, excluded: ['maquina'])
    render json: @coleccion
  end

end
