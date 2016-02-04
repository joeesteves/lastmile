class Reporteador
  def initialize reporte, opts = {}
    @reporte = 'fertilizadoras'
    @precio_gasoil = opts[:precio_gasoil] || 1
  end

  def generar
    hsh = {}

    Labor.sup(@reporte).each do |k,v|
      hsh[k] = Resumen.new k, superficie: v[:superficie]
    end

    Mantenimiento.resumen(@reporte, @precio_gasoil).each do |k,v|
      hsh[k] ||= Resumen.new k
      hsh[k].update(v)
    end

    hsh.inject([]) do |ary, (k,v)|
      ary.push(v.as_json)
      ary
    end

  end

end
