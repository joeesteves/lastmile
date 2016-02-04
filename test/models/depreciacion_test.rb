require 'test_helper'

class DepreciacionTest < ActiveSupport::TestCase
  test  "Importar XLS" do
    UploadWorker.jobs.clear
    reporte = 'todos'
    file = File.open 'test/files/depreciacion.xls'
    Depreciacion.importar file, reporte
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Depreciacion.where(reporte: reporte).count == 1, "Las lineas en la tabla (#{Depreciacion.where(reporte: reporte).count }) no coinciden con las del archivo"
  end
end
