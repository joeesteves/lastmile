require 'test_helper'
require 'sidekiq/testing'

class CompraTest < ActiveSupport::TestCase
  test  "Importar XLS" do
    UploadWorker.jobs.clear
    file = File.open 'test/files/compras.xls'
    Compra.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Compra.where(reporte: 'fertilizadoras').count == 172, "Las lineas en la tabla (#{Compra.where(reporte: 'fertilizadoras').count}) no coinciden con las del archivo"
  end
  test  "Importar XLS con encabezado ceres y adaptar" do
    UploadWorker.jobs.clear
    file = File.open 'test/files/compras_ceres.xls'
    Compra.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    @compra = Compra.where(reporte: 'fertilizadoras').first
    assert Compra.where(reporte: 'fertilizadoras').count == 1, "Las lineas en la tabla (#{Compra.where(reporte: 'fertilizadoras').count}) no coinciden con las del archivo"
    assert @compra.maquina == 'CAMION FOTON CON VOLCADORA 6*2 2014 (374)', 'no traduce bien dim valor'
    assert @compra.insumo == 'REPARACIONES Y MANTENIMIENTOS NO ADM. VEHICULOS', 'no traduce bien producto'
    assert @compra.obs == 'iNSTALACION ELECTRICA Y COLOCACION DE BOCINA DE AIRE EN CAMION FOTOS', 'no traduce bien obs'
    assert @compra.proveedor == 'WALDEMAR PEREZ', 'proveedor'
    assert @compra.valor == 28.81
    assert @compra.fecha == Date.strptime('2015-07-01'), 'no traduce bien fecha comprobante'

  end

end
