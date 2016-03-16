require 'test_helper'
require 'sidekiq/testing'


class LaborTest < ActiveSupport::TestCase
  test  "Importar CSV labores de fertilizacion" do
    UploadWorker.jobs.clear
    file = File.open 'test/files/labores.csv'
    Labor.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo 4 del fixtures
    assert Labor.where(reporte: 'fertilizadoras').count == 5, 'Las lineas en la tabla no coinciden con las del archivo '
  end
  test  "Estados de importaciones" do
    UploadWorker.jobs.clear
    file = File.open 'test/files/labores.csv'
    Labor.importar(file, 'fertilizadoras')
    assert Estado.find_by(referencia: 'fertilizadoras_labores').valor == 'proceso'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    assert Estado.find_by(referencia: 'fertilizadoras_labores').valor == 'terminado'
  end
  test "por actividad" do
    resumen = Labor.por_actividad('fertilizadoras')
    beta = resumen.select {|i| i['maquina'] == 'beta' }
    alfa = resumen.select {|i| i['maquina'] == 'alfa' }
    assert alfa[0]['actividades'][0]['superficie'].to_f == 20
    assert beta[0]['actividades'][0]['superficie'].to_f == 5
  end
end
