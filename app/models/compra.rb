class Compra < ActiveRecord::Base
  include Importador
  SINONIMOS = {
    'dim. valor': 'maquina',
    'f.comprobante': 'fecha',
    'producto': 'insumo',
    'descripción item': 'obs',
    'importe mon. secundaria': 'valor'
  }

end
