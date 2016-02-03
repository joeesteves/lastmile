class EstadosController < ApplicationController
  def check
    puts 'parametrooooo' + params[:referencia]
    if @estado = Estado.find_by(referencia: params[:referencia])
      render json: @estado.valor.to_json
    else
      head 404
    end
  end

end
