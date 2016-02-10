class ReporteadorController < ApplicationController
  def index
    tipo = params[:tipo]
    opts = {}
    opts[:precio_gasoil] = params[:precio_gasoil].to_f if params[:precio_gasoil].to_f > 0
    @informe = Reporteador.new(tipo, opts).generar
    render json: @informe
  end

end
