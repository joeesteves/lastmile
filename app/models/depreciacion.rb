class Depreciacion < ActiveRecord::Base
  include Importador
  def self.maquina maquina
    cuota = find_by(maquina: maquina).cuota
    {depreciacion: cuota}
  end

end

Depreciacion::SINONIMOS = {
  'vida util': 'vidautil'
}
