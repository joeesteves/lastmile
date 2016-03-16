require 'test_helper'

class ReporteadorTest < ActiveSupport::TestCase
  # test  "Hash base reporte" do
  #   resumen = Resumen.new 'alfa', superficie: 20, horas: 100, gastos_varios: 15.33, depreciacion: 20, gasoil_cantidad:200, gasoil_costo: 400, costo_operarios: 7000, nombre_operarios: ['Jorge Cafrune']
  #   assert resumen.total == 7435.33
  #   alfa = Reporteador.new('fertilizadoras', precio_gasoil: 2).generar.select{|i| i["nombre"] == 'alfa'}[0]
  #   assert alfa == resumen.as_json
  # end
  # test  "Hash base reporte 2" do
  #   resumen = Resumen.new 'beta', superficie: 10, horas: 0, gastos_varios: 261.22, depreciacion: 16, gasoil_cantidad:0, gasoil_costo: 0, costo_operarios: 10500, nombre_operarios: ['Jorge Cafrune', 'Pepe Gomez']
  #   assert resumen.total == 10777.22
  #   beta = Reporteador.new('fertilizadoras').generar.select{|i| i["nombre"] == 'beta'}[0]
  #   assert  beta == resumen.as_json
  # end
  #
  # test  "Nombre de operarios" do
  #   a = Resumen.new 'beta', nombre_operarios: ['Jorge Cafrune', 'Pepe Gomez']
  #   assert a.nombre_operarios == 'Jorge Cafrune y Pepe Gomez'
  #   b = Resumen.new 'beta', nombre_operarios: ['Jorge Cafrune','Carlos Espinoza', 'Pepe Gomez']
  #   assert b.nombre_operarios == 'Jorge Cafrune, Carlos Espinoza y Pepe Gomez'
  # end
  test  "fumigadoras con implementos" do
    a = Reporteador.new('fumigadoras', precio_gasoil: 1).generar.select{|i| i["nombre"] == 'mosquito'}[0]
    # byebug
    assert_equal 1750, a['gastos_varios']
    assert_equal 25, a['gasoil_cantidad']
    assert_equal 25, a['gasoil_costo']
    assert_equal 1775, a['total']


  end

end
