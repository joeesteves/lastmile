class Labor < ActiveRecord::Base
  include Importador

  def self.sup
    group(:maquina).sum(:superficie).inject({}) {|hsh,(k,v)| hsh[k] = {superficie: v}; hsh }
  end



end