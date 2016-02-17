class Labor < ActiveRecord::Base
  include Importador
  SINONIMOS = {
    'descripción': 'obs',
    'documento': 'doc'
  }


  def self.resumen reporte, args = {}
    where(reporte: reporte).group(:maquina).sum(:superficie).inject({}) {|hsh,(k,v)| hsh[k] = {superficie: v}; hsh}
  end

  def self.por_actividad reporte
    maquinas = select(:maquina).distinct(:maquinas).where(reporte: reporte)
    maquinas.inject([]) do |ary,item|
      hsh = {}
      hsh[:maquina] = item.maquina
      hsh[:actividades]  = where(reporte: reporte, maquina: item.maquina).select("actividad as nombre, SUM(superficie) as superficie").group(:actividad).order(:actividad)
      ary.push hsh
      ary.as_json
    end

  end



end
