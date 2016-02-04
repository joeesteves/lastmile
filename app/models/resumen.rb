class Resumen
  attr_accessor :nombre, :superficie, :horas, :gasoil_cantidad, :gasoil_costo, :gastos_varios, :depreciacion, :costo_operarios, :nombre_operarios

  def initialize nombre, args = {}
    @nombre = nombre
    @superficie = args[:superficie].to_f || 0.00
    @horas = args[:horas].to_i || 0
    @gasoil_cantidad = args[:gasoil_cantidad].to_f || 0.00
    @gasoil_costo = args[:gasoil_costo].to_f || 0.00
    @gastos_varios = args[:gastos_varios].to_f || 0.00
    @depreciacion = args[:depreciacion].to_f || 0.00
    @costo_operarios = args[:operarios] || []
    @nombre_operarios = args[:operarios] || []
  end
  def update args = {}
    args.each {|k,v| self.send(k.to_s+'=',v) }
  end
end
