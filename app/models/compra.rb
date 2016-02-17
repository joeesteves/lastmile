class Compra < ActiveRecord::Base
  include Importador, Comun
  SINONIMOS = {
    'dim. valor': 'maquina',
    'f.comprobante': 'fecha',
    'producto': 'insumo',
    'descripción item': 'obs',
    'importe mon. secundaria': 'valor'
  }

  def self.maquina maquina
    where(maquina: maquina).sum(:valor).to_f
  end

  def self.detalle reporte, args = {}
    super reporte, [:fecha, :proveedor, :comprobante, :doc, :obs], [['nombre', :insumo], :valor], args
  end

end
