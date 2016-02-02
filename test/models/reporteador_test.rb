require 'test_helper'

class ReporteadorTest < ActiveSupport::TestCase
  test  "Hash base reporte" do
    assert Reporteador.new('fertilizadoras', precio_gasoil: 2).generar.select{|i| i[:nombre] == 'alfa'} == [{superficie: 20, horas: 100, gasoil: {cantidad: 200, costo:400}, gastos_varios: 0, nombre: 'alfa'}]
  end
  test  "Hash base reporte 2" do
    assert Reporteador.new('fertilizadoras').generar.select{|i| i[:nombre] == 'beta'} == [{superficie: 10, horas: 0, gasoil: {cantidad: 0, costo:0}, gastos_varios: 250, nombre: 'beta'}]
  end


end
