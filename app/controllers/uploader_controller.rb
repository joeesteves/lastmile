class UploaderController < ApplicationController
  
  def create
    tipo = params[:tipo].classify.constantize
    reporte = params[:reporte]
    file = params[:file]
    if tipo.importar file, reporte
      head 200
    else
      render json: {errors: 'hubo un problema'}, status: 422
    end
  end
end
