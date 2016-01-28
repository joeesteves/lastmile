require 'roo'
module Importador
	extend ActiveSupport::Concern
	module ClassMethods
		def importar file, reporte
			case File.extname(file)
			when '.csv' then csv file, reporte
			end
		end

		private
			def csv file, reporte
				CSV.foreach(file.path, headers: true, header_converters: :symbol, col_sep: ';') do |row|
					reg = row.to_hash.select do |k|
						(self.column_names + self.instance_methods(false).map { |i| i.to_s.gsub('=','')}).map(&:to_sym).include? k
					end
					self.create! reg.merge({reporte: reporte})
				end
			end
			

	end
end
