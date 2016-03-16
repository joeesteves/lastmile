class Persona < ActiveRecord::Base
  include Importador

  def self.maquina maquina
    hsh = {nombre_operarios: [], costo_operarios: 0}
    where(maquina: maquina).each do |item|
      hsh[:nombre_operarios] = hsh[:nombre_operarios].push item.nombre
      hsh[:costo_operarios] += ( item.costo.to_f * item.porcentaje / 100 )
    end
    hsh
  end
end

Persona::SINONIMOS = {
  'persona': 'nombre'
}
