class UploadWorker
  include Sidekiq::Worker

  def perform(klass, file_path, reporte, referencia)
    @klass = klass.constantize
    file = File.open file_path
    case File.extname(file)
    when '.csv' then csv file_path, reporte
    when ".xlsx" then xlsx file_path, reporte
    when ".xls" then xls file_path, reporte
    end
    Estado.find_by(referencia: referencia).update(valor: 'terminado')
  end

  private
    def csv file_path, reporte
      ActiveRecord::Base.transaction do
        CSV.foreach(file_path, headers: true, header_converters: :symbol, col_sep: ';') do |row|
          reg = filter row.to_hash
          @klass.create! reg.merge({reporte: reporte})
        end
      end
      true
    end

    def xlsx file_path, reporte
      hoja = Roo::Excelx.new(file_path)
      mass_import reporte, hoja
    end

    def xls file_path, reporte
      hoja = Roo::Excel.new(file_path)
      mass_import reporte, hoja
    end

    def mass_import reporte, hoja
      headers = headerify hoja
      columns = headers[:head]
      values = []
      table = @klass.table_name
      (2..hoja.last_row).each do |i|
        obj = hoja.row(i)
        headers[:del_index].each_with_index {|i,index| obj.slice!(i-index)}
        # byebug
        obj.map!{|i| i || '0' }
        item = "(" + obj.push(reporte, DateTime.now.to_s,DateTime.now.to_s).map{|i| "'"+i.to_s+"'" }.join(', ') + ")"
        values.push item
      end
      sql = "INSERT INTO #{table} (#{columns}) VALUES #{values.join(', ')}"
      conn = ActiveRecord::Base.connection
      conn.execute sql
      true
    end

    def headerify hoja
      head = hoja.row(1).map do |h|
        h = '' unless h
        @klass::SINONIMOS[h.downcase.to_sym] || h.downcase
      end
      del_index = del_index head
      del_index.each_with_index {|i,index| head.slice!(i-index)}
      head.push('reporte','created_at', 'updated_at')
      {head: head.join(', '), del_index: del_index }
    end

    def del_index head
      del_index = []
      head.each_with_index do |c, index|
        del_index.push(index) unless @klass.column_names.include? c
      end
      del_index
    end


    def filter hsh
      hsh.select do |k|
        (@klass.column_names + @klass.instance_methods(false).map { |i| i.to_s.gsub('=','')}).map(&:to_sym).include? k
      end
    end
end
