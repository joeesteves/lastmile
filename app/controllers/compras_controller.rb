class ComprasController < ApplicationController
  def index
    reporte = params[:reporte]
    @coleccion = Compra.detalle(reporte, excluded: ['maquina'])
    render json: @coleccion
  end

end
