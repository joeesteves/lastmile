class ReporteadorController < ApplicationController
  def index
    tipo = params[:tipo]
    @informe = Reporteador.new(tipo).generar
    render json: @informe
  end

end
