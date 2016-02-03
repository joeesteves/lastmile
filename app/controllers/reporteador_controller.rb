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
    if tipo.importar file, reporte
      puts 'acaaaaaaaaaaaaaaaa ' + reporte
      render json: tipo.all
    else
      render json: {errors: 'hubo un problema'}, status: 422
    end
  end
end
