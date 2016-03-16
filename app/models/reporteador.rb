class Reporteador
  def initialize reporte, opts = {}
    @reporte = reporte
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
      hsh[k].gastos_varios += Compra.maquina(k)
      hsh[k].update Persona.maquina(k)
      hsh[k].update Depreciacion.maquina(k)
    end
    Asociacion.where(reporte: @reporte).each do |asoc|
      if hsh[asoc.maquina]
        porcentaje = asoc.porcentaje
        hsh[asoc.maquina].gastos_varios += (hsh[asoc.implemento].gastos_varios * porcentaje) / 100
        hsh[asoc.maquina].gasoil_cantidad += (hsh[asoc.implemento].gasoil_cantidad * porcentaje) / 100
        hsh[asoc.maquina].gasoil_costo += (hsh[asoc.implemento].gasoil_costo * porcentaje) / 100
        hsh[asoc.maquina].depreciacion += (hsh[asoc.implemento].depreciacion * porcentaje) / 100
        hsh[asoc.maquina].costo_operarios += (hsh[asoc.implemento].costo_operarios * porcentaje) / 100
        hsh[asoc.maquina].calcula_total
      end
    end
    Asociacion.where(reporte: @reporte).select(:implemento).distinct.each do |item|
      hsh.delete(item.implemento)
    end

    c = Resumen.new "CONSOLIDADO"
    hsh.each do |k,v|
      c.superficie += v.superficie
      c.horas += v.horas
      c.gasoil_cantidad += v.gasoil_cantidad
      c.gasoil_costo += v.gasoil_costo
      c.gastos_varios += v.gastos_varios
      c.depreciacion += v.depreciacion
      c.costo_operarios += v.costo_operarios
    end

    c.calcula_total
    hsh["Consolidado"] = c
    hsh.inject([]) { |ary, (k,v)| ary.push(v.as_json); ary }
  end

end
