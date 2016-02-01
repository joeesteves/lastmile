require 'test_helper'

class LaborTest < ActiveSupport::TestCase
  test  "Importar CSV labores de fertilizacion" do
    file = File.open 'test/files/labores.csv'
    Labor.importar file, 'fertilizadoras'
    # 5 del archivo 4 del fixtures
    assert Labor.all.count == 9, 'Las lineas en la tabla no coinciden con las del archivo '
  end
  test  "Al importarsin errores devuleve true" do
    file = File.open 'test/files/labores.csv'
    assert Labor.importar file, 'fertilizadoras' == true
  end
end
