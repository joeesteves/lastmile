require 'test_helper'
require 'sidekiq/testing'

class MantenimientoTest < ActiveSupport::TestCase
  test  "Importar CSV mantenimientos de fertilizacion" do
    UploadWorker.jobs.clear
    file = File.open 'test/files/mantenimientos.csv'
    Mantenimiento.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Mantenimiento.all.count == 5, "Las lineas en la tabla (#{Mantenimiento.all.count } )no coinciden con las del archivo"
  end
  test  "Importar XLSX mantenimientos de fertilizacion" do
    UploadWorker.jobs.clear
    file = File.open 'test/files/mantenimientos.xlsx'
    Mantenimiento.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Mantenimiento.all.count == 5, "Las lineas en la tabla (#{Mantenimiento.all.count } )no coinciden con las del archivo"
  end

  test  "Importar XLS" do
    UploadWorker.jobs.clear
    file = File.open 'test/files/mantenimientos.xls'
    Mantenimiento.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Mantenimiento.all.count == 5, "Las lineas en la tabla (#{Mantenimiento.all.count } )no coinciden con las del archivo"
  end
  test  "Importar XLS mant de fertilizacion directo de ceres" do
    UploadWorker.jobs.clear
    file = File.open 'test/files/mant.xls'
    Mantenimiento.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1, "jobs #{UploadWorker.jobs.count}"
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Mantenimiento.all.count == 3, "Las lineas en la tabla (#{Mantenimiento.all.count } )no coinciden con las del archivo"
  end
  test  "Importar XLS mant_con_faltantes de fertilizacion directo de ceres" do
    UploadWorker.jobs.clear
    file = File.open 'test/files/mant_con_faltantes.xls'
    Mantenimiento.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1, "jobs #{UploadWorker.jobs.count}"
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Mantenimiento.all.count == 14, "Las lineas en la tabla (#{Mantenimiento.all.count } )no coinciden con las del archivo"
  end
  test  "Importar XLS con columna nil la use para calculos y nunca le puse header" do
    UploadWorker.jobs.clear
    file = File.open 'test/files/mant_complicado.xls'
    Mantenimiento.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1, "jobs #{UploadWorker.jobs.count}"
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Mantenimiento.all.count == 3, "Las lineas en la tabla (#{Mantenimiento.all.count } )no coinciden con las del archivo"
  end
  test  "resumen" do
    resumen = Mantenimiento.resumen 'fertilizadoras', precio_gasoil: 2
    assert resumen['alfa'][:gasoil_cantidad] == 200
  end

  test 'detalle' do
    detalle = Mantenimiento.detalle('fertilizadoras')
    assert detalle.is_a?(Array), 'detalle not array'
    assert detalle.length == 1, 'array no tiene el tamaño correcto'
    assert detalle.first.is_a?(Hash), 'detalle first no es objeto'
    assert detalle.first["detalle"].first["insumos"].is_a?(Array), 'insumos no es un array'
    beta = detalle.select {|i| i['maquina'] == 'beta' }
    assert beta[0]['detalle'].is_a?(Array), 'detalle not array'
  end

end
