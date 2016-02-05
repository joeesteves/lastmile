class Depreciacion < ActiveRecord::Base
  include Importador
  def self.maquina maquina
    {depreciacion: find_by(maquina: maquina).cuota}
  rescue
    {depreciacion: 0}
  end
end

Depreciacion::SINONIMOS = {
  'vida util': 'vidautil'
}
