class Reporteador
  def initialize reporte, opts = {}
    @reporte = 'fertilizadoras'
    @precio_gasoil = opts[:precio_gasoil] || 1
  end

  def generar
    hsh = {}
    [Labor, Mantenimiento].each do |klass|
      klass.resumen(@reporte, precio_gasoil: @precio_gasoil).each do |k,v|
        hsh[k] ||= Resumen.new k
        hsh[k].update(v)
      end
    end
    hsh.each do |k,v|
      hsh[k].update Persona.maquina(k)
      hsh[k].update Depreciacion.maquina(k)
    end
    hsh.inject([]) { |ary, (k,v)| ary.push(v.as_json); ary }
  end

end
