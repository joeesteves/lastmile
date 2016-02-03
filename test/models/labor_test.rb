require 'test_helper'
require 'sidekiq/testing'


class LaborTest < ActiveSupport::TestCase
  test  "Importar CSV labores de fertilizacion" do
    file = File.open 'test/files/labores.csv'
    Labor.importar file, 'fertilizadoras'
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo 4 del fixtures
    assert Labor.all.count == 5, 'Las lineas en la tabla no coinciden con las del archivo '
  end
  test  "Al importarsin errores devuleve true" do
    file = File.open 'test/files/labores.csv'
    assert Labor.importar file, 'fertilizadoras' == true
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
  end
end
