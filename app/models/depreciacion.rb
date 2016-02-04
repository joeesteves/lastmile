class Depreciacion < ActiveRecord::Base
  include Importador
  SINONIMOS = {
    'vida util': 'vidautil'
  }
end
