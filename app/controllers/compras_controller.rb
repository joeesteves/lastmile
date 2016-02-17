class ComprasController < ApplicationController
  def index
    reporte = params[:reporte]
    @coleccion = Compra.detalle(reporte)
    render json: @coleccion
  end

end
