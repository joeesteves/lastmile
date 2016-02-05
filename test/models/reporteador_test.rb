require 'test_helper'

class ReporteadorTest < ActiveSupport::TestCase
  test  "Hash base reporte" do
    resumen = Resumen.new 'alfa', superficie: 20, horas: 100, gastos_varios: 0, depreciacion: 20, gasoil_cantidad:200, gasoil_costo: 400, costo_operarios: 7000, nombre_operarios: ['Jorge Cafrune']
    alfa = Reporteador.new('fertilizadoras', precio_gasoil: 2).generar.select{|i| i["nombre"] == 'alfa'}[0]
    assert alfa == resumen.as_json
  end
  test  "Hash base reporte 2" do
    resumen = Resumen.new 'beta', superficie: 10, horas: 0, gastos_varios: 250, depreciacion: 16, gasoil_cantidad:0, gasoil_costo: 0, costo_operarios: 10500, nombre_operarios: ['Jorge Cafrune', 'Pepe Gomez']

    beta = Reporteador.new('fertilizadoras').generar.select{|i| i["nombre"] == 'beta'}[0]
    assert  beta == resumen.as_json
  end

end
