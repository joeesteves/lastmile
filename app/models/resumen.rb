class Resumen
  include CustomAccessor
  attr_reader :nombre_operarios
  custom_accessor to_s: [:nombre], to_f: [:superficie, :horas, :gasoil_cantidad, :gasoil_costo, :gastos_varios, :depreciacion, :costo_operarios, :total]

  def initialize nombre, args = {}
    @nombre = nombre
    @superficie = args[:superficie] || 0.00
    @horas = args[:horas] || 0
    @gasoil_cantidad = args[:gasoil_cantidad] || 0.00
    @gasoil_costo = args[:gasoil_costo] || 0.00
    @gastos_varios = args[:gastos_varios] || 0.00
    @depreciacion = args[:depreciacion] || 0.00
    @costo_operarios = args[:costo_operarios] || 0.00
    @nombre_operarios = humanize(args[:nombre_operarios]) || ''
    calcula_total
  end

  def nombre_operarios=(nombres)
    @nombre_operarios = humanize(nombres)
  end

  def update args = {}
    args.each {|k,v| self.send(k.to_s+'=',v) }
    calcula_total
  end
  def calcula_total
    @total = gastos_varios + gasoil_costo + depreciacion + costo_operarios
  end

  def humanize(nombres)
    if nombres.is_a? Array
      nombres.join(', ').gsub /,( [^,]+$)/, ' y\1'
    else
      nombres
    end
  end
end
