module Importador
	extend ActiveSupport::Concern
	module ClassMethods
		def importar file, reporte
      self.clean reporte
      UploadWorker.perform_async(self.to_s, file.path, reporte)
		end

    def clean reporte
      where(reporte: reporte).delete_all
    end

	end
end
