class MantenimientosController < ApplicationController
  def index
    reporte = params[:reporte]
    @coleccion = Mantenimiento.detalle(reporte, solo_gasoil: params[:solo_gasoil].to_i)
    render json: @coleccion
  end

end
