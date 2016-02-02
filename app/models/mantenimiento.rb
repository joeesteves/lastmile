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


  def self.horas
    max = group(:maquina).maximum(:horometro)
    min = group(:maquina).minimum(:horometro)
    max.inject({}) do |hsh,(k,v)|
      hsh[k] = (v - min[k]).to_i
      hsh
    end
  end
  def self.gasoil(precio)
    where("insumo like '%gasoil%'").group(:maquina).sum(:cantidad).inject({}) do |hsh,(k,v)|
      hsh[k] = {cantidad: v.to_i, costo: (v * precio).to_f }
      hsh
    end
  end
  def self.gastos_varios
    where("insumo not like '%gasoil%'").group(:maquina).sum("cantidad * costoestandar").inject({}) do |hsh,(k,v)|
      hsh[k] = v.to_i
      hsh
    end
  end

end
