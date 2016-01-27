class Reporteador
  def initialize opts = {}
    @precio_gasoil = opts[:precio_gasoil] || 1
  end

  def fertilizadoras
    #obtengo hash k = nombre de la maquina y un v = un hash con superficie
    hsh = Labor.where(reporte:'fertilizadoras').sup
    hsh.each do |k,v|
      hsh[k].merge!({horas: 0, gasoil: {cantidad: 0, costo: 0}, gastos_varios: 0})
    end
    Mantenimiento.where(reporte:'fertilizadoras').horas.each do |k,v|
      hsh[k][:horas] = v
    end
    Mantenimiento.where(reporte:'fertilizadoras').gasoil(@precio_gasoil).each do |k,v|
      hsh[k][:gasoil] = v
    end
    Mantenimiento.gastos_varios.each do |k,v|
      hsh[k][:gastos_varios] = v
    end
    hsh

  end

end
