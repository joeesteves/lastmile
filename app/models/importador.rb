module Importador
	extend ActiveSupport::Concern
	module ClassMethods
		def importar file, reporte
      referencia = [reporte, '_', self.table_name].join()
      estado = Estado.find_or_create_by!(referencia: referencia)
      estado.update valor: 'proceso'
      self.clean reporte
      UploadWorker.perform_async self.to_s, file.path, reporte, referencia
		end

    def clean reporte
      where(reporte: reporte).delete_all
    end

	end
end
