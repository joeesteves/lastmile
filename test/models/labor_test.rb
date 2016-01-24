require 'test_helper'

class LaborTest < ActiveSupport::TestCase
  test  "Importar CSV" do
    file = File.open 'test/files/labores.csv'
    Labor.importar file
    byebug
    assert Labor.all.count == 5, 'Las lineas en la tabla no coinciden con las del archivo '

  end
end
