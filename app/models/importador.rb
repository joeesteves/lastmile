module Importador
	extend ActiveSupport::Concern
	module ClassMethods
		def importar file
			CSV.foreach(file.path, headers: true, col_sep: ';' ) do |row|
				Labor.create! row.to_hash
			end
		end
	end
end
