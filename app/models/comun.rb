module Comun
	extend ActiveSupport::Concern
	module ClassMethods
		def detalle reporte, args = {}
	    args[:exlcluded] ||= []
	    cols = column_names.select{|i| i unless i =~ /_at/ } - args[:exlcluded]
	    excluir_gasoil = ''
	    excluir_gasoil = "insumo not ilike 'gasoil%' and insumo <> ''" if self == Mantenimiento
	    maquinas = select(:maquina).distinct(:maquina).where(reporte: reporte).where(excluir_gasoil).order(:maquina).map{|i| {maquina: i.maquina}}
	    maquinas.each do |maquina_resumen|
	      maquina = maquina_resumen[:maquina]
	      maquina_resumen[:detalle] = select(cols).where(maquina: maquina, reporte: reporte).where(excluir_gasoil).order(:maquina, :fecha)
	    end
	    maquinas.as_json
	  end
	end
end
