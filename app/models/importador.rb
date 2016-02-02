module Importador
	extend ActiveSupport::Concern
	module ClassMethods
		def importar file, reporte
			case File.extname(file)
			when '.csv' then csv file, reporte
			when ".xlsx" then xlsx file, reporte
			when ".xls" then xls file, reporte
			end
		end

    def clean reporte
      where(reporte: reporte).delete_all
    end

		private
			def csv file, reporte
        ActiveRecord::Base.transaction do
  				CSV.foreach(file.path, headers: true, header_converters: :symbol, col_sep: ';') do |row|
  					reg = filter row.to_hash
            self.create! reg.merge({reporte: reporte})
  				end
        end
        true
      end

			def xlsx file, reporte
				hoja = Roo::Excelx.new(file.path)
        header = hoja.row(1).map{ |h| h.downcase.to_sym}
        ActiveRecord::Base.transaction do
    			(2..hoja.last_row).each do |i|
      	 		reg = filter Hash[[header, hoja.row(i)].transpose]
            self.create! reg.merge({reporte: reporte})
          end
        end
        true
			end

			def xls file, reporte
				hoja = Roo::Excel.new(file.path)
				header = hoja.row(1).map{ |h| h.downcase.to_sym}
        ActiveRecord::Base.transaction do
          (2..hoja.last_row).each do |i|
  					reg = filter Hash[[header, hoja.row(i)].transpose]
  					self.create! reg.merge({reporte: reporte})
  				end
        end
        true
			end


			def filter hsh
				hsh.select do |k|
					(self.column_names + self.instance_methods(false).map { |i| i.to_s.gsub('=','')}).map(&:to_sym).include? k
				end
			end
	end
end
