class ReporteadorController < ApplicationController
  def index
    tipo = params[:tipo]
    @informe = Reporteador.new(tipo).generar
    render json: @informe
  end

  def create
    tipo = params[:tipo].classify.constantize
    reporte = params[:reporte]
    file = params[:file]
    tipo.clean reporte
    if tipo.importar file.open, reporte
      render json: tipo.all
    else
      render json: {errors: 'hubo un problema'}, status: 422
    end
  end
end
