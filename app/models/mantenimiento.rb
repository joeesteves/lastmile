class Mantenimiento < ActiveRecord::Base
  include Importador

  def insumonombre=(valor)
    self.insumo = valor
  end
  def insumocantidad=(valor)
    self.cantidad = valor
  end
  def costostandard=(valor)
    self.costoestandar = valor
  end

  def self.resumen reporte, precio_gasoil
    filtrado = self.where(reporte: reporte)
    hsh = {}
    horas filtrado, hsh
    gasoil filtrado, hsh, precio_gasoil
    gastos_varios filtrado, hsh
    hsh
  end

  def self.horas filtrado, hsh
    max = filtrado.group(:maquina).maximum(:horometro)
    min = filtrado.group(:maquina).minimum(:horometro)
    max.each do |k,v|
      hsh[k] = {horas: (v - min[k]).to_i}
    end
  end

  def self.gasoil filtrado, hsh, precio
    filtrado.where("insumo like '%gasoil%'").group(:maquina).sum(:cantidad).each do |k,v|
      hsh[k].merge!({gasoil_cantidad: v.to_i, gasoil_costo: (v * precio).to_f })
    end
  end

  def self.gastos_varios filtrado, hsh
    filtrado.where("insumo not like '%gasoil%'").group(:maquina).sum("cantidad * costoestandar").each do |k,v|
      hsh[k].merge!({gastos_varios: v.to_i})
    end
  end

end
