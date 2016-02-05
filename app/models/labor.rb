class Labor < ActiveRecord::Base
  include Importador

  def self.resumen reporte, args = {}
    where(reporte: reporte).group(:maquina).sum(:superficie).inject({}) {|hsh,(k,v)| hsh[k] = {superficie: v}; hsh}
  end



end
