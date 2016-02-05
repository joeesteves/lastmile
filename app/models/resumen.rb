class Resumen
  include CustomAccessor
  attr_accessor :nombre_operarios
  custom_accessor to_s: [:nombre], to_f: [:superficie, :horas, :gasoil_cantidad, :gasoil_costo, :gastos_varios, :depreciacion, :costo_operarios]

  def initialize nombre, args = {}
    @nombre = nombre
    @superficie = args[:superficie] || 0.00
    @horas = args[:horas] || 0
    @gasoil_cantidad = args[:gasoil_cantidad] || 0.00
    @gasoil_costo = args[:gasoil_costo] || 0.00
    @gastos_varios = args[:gastos_varios] || 0.00
    @depreciacion = args[:depreciacion] || 0.00
    @costo_operarios = args[:costo_operarios] || 0.00
    @nombre_operarios = args[:nombre_operarios] || []
  end

  def update args = {}
    args.each {|k,v| self.send(k.to_s+'=',v) }
  end

end
