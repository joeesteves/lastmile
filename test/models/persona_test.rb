require 'test_helper'

class PersonaTest < ActiveSupport::TestCase
  test  "Importar XLS" do
    UploadWorker.jobs.clear
    reporte = 'todos'
    file = File.open 'test/files/persona.xls'
    Persona.importar file, reporte
    assert UploadWorker.jobs.count == 1
    UploadWorker.drain
    # 5 del archivo mas 4 fixtures
    assert Persona.where(reporte: reporte).count == 5, "Las lineas en la tabla (#{Persona.where(reporte: reporte).count }) no coinciden con las del archivo"
    assert Persona.last.nombre == 'Pedro Gomez'
    assert Persona.first.nombre == 'Jose Esteves', "#{Persona.first.nombre}"
    assert Persona.first.costo == 10000, "#{Persona.first.costo}"
    assert Persona.find_by(nombre: 'Jorge Cafrune').maquina == 'TRACTOR 222'
    assert Persona.find_by(nombre: 'Jorge Cafrune').porcentaje == 100
  end
  test  "calculo con fixtures alfa" do
    respuesta = Persona.maquina('alfa')
    espero = {nombre_operarios: ['Jorge Cafrune'], costo_operarios: 7000 }
    assert respuesta == espero
  end
  test  "calculo con fixtures beta" do
    respuesta = Persona.maquina('beta')
    espero = {nombre_operarios: ['Jorge Cafrune', 'Pepe Gomez'], costo_operarios: 10500 }
    assert respuesta == espero
  end

end
