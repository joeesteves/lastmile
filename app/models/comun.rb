module Comun
	extend ActiveSupport::Concern
	module ClassMethods
		def detalle reporte, args = {}
	    args[:exlcluded] ||= []
	    cols = column_names.select{|i| i unless i =~ /_at/ } - args[:exlcluded]
	    gasoil_query = ''
	    gasoil_query = "insumo not ilike 'gasoil%' and insumo <> ''" if self == Mantenimiento
      gasoil_query = "insumo ilike 'gasoil%'" if args[:solo_gasoil] == 1
	    maquinas = select(:maquina).distinct(:maquina).where(reporte: reporte).where(gasoil_query).order(:maquina).map{|i| {maquina: i.maquina}}
	    maquinas.each do |maquina_resumen|
	      maquina = maquina_resumen[:maquina]
	      maquina_resumen[:detalle] = select(cols).where(maquina: maquina, reporte: reporte).where(gasoil_query).order(:maquina, :fecha)
	    end
	    maquinas.as_json
	  end
	end
end
