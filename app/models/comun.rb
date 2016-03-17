module Comun
	extend ActiveSupport::Concern
	module ClassMethods
		def detalle reporte, group_fields, detalle_fields, args = {}
      @reporte = reporte
	    cols = column_names.select{|i| i unless i =~ /_at/ } - ['id', 'reporte', 'maquina', 'insumo', 'cantidad','costoestandar', 'valor']
	    @gasoil_query = ''
	    @gasoil_query = "insumo not ilike 'gasoil%' and insumo <> ''" if self == Mantenimiento
      @gasoil_query = "insumo ilike 'gasoil%'" if args[:solo_gasoil] == 1
      @implementos = Asociacion.where(reporte: @reporte).select(:implemento).collect(&:implemento)
      @implementos = [''] if @implementos.empty?
      maquinas = get_maquinas('maquina not IN (?)') | get_maquinas('maquina IN (?)')
      sql_detalle = []
			detalle_fields.each do |field|
				if field.is_a? Symbol
					field = field.to_s
					sql_detalle.push("'"+field+"'")
					sql_detalle.push(field)
				elsif field.is_a? Array
					sql_detalle.push("'"+field[0].to_s+"'")
					sql_detalle.push(field[1].to_s)
				end
			end
			sql = "json_agg(json_build_object(#{sql_detalle.join(', ')})) as insumos"
			maquinas.each do |maquina_resumen|
	      maquina = maquina_resumen[:maquina]
	      maquina_resumen[:detalle] = select(cols).select(sql).where(maquina: maquina, reporte: @reporte).where(@gasoil_query).group(*group_fields).order(:fecha)
	    end
	    maquinas.as_json
	  end
  private
    def get_maquinas(maquinas_sql)
      select(:maquina).distinct(:maquina).where(reporte: @reporte).where(@gasoil_query).where(maquinas_sql, @implementos).order(:maquina).map{|i| {maquina: i.maquina}}
    end
	end
end
