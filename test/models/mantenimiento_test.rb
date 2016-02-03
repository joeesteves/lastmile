require 'test_helper'
require 'sidekiq/testing'

class MantenimientoTest < ActiveSupport::TestCase
  test  "Importar CSV mantenimientos de fertilizacion" do
    file = File.open 'test/files/mantenimientos.csv'
    Mantenimiento.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    assert UploadWorker.jobs.count == 0
    # 5 del archivo mas 4 fixtures
    assert Mantenimiento.all.count == 9, "Las lineas en la tabla (#{Mantenimiento.all.count } )no coinciden con las del archivo"
  end
  test  "Importar XLSX mantenimientos de fertilizacion" do
    file = File.open 'test/files/mantenimientos.xlsx'
    Mantenimiento.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Mantenimiento.all.count == 9, "Las lineas en la tabla (#{Mantenimiento.all.count } )no coinciden con las del archivo"
  end

  test  "Importar XLS" do
    file = File.open 'test/files/mantenimientos.xls'
    Mantenimiento.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Mantenimiento.all.count == 9, "Las lineas en la tabla (#{Mantenimiento.all.count } )no coinciden con las del archivo"
  end
  test  "Importar XLS mant de fertilizacion directo de ceres" do
    file = File.open 'test/files/mant.xls'
    Mantenimiento.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Mantenimiento.all.count == 7, "Las lineas en la tabla (#{Mantenimiento.all.count } )no coinciden con las del archivo"
  end


  test  "horometro con fixtures" do
    assert Mantenimiento.horas['alfa'] == 100
  end

  test  "gasoil" do
    assert Mantenimiento.gasoil(2)['alfa'] == {cantidad: 200, costo: 400}
  end

  test  "gastos varios insumos" do
    assert Mantenimiento.gastos_varios['beta'] == 250
  end


end
