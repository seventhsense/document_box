class XlsToText
  def initialize(path)
    @file_path = File.dirname path
    @tmp_path = @file_path
    @extname = File.extname path
    @filename = File.basename path, @extname
  end

  def excute
    t = ''
    begin
      if @extname == '.xlsx'
        xls = Roo::Spreadsheet.open xls_file_path
      else # @extname == 'xls'
        xls = Roo::Excel.new xls_file_path
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    ensure
      xls.sheets.each do |sheet|
        t << xls.sheet(sheet).to_csv
      end
    end
    return t
  end

  def xls_file_path
    [@file_path, @filename + @extname].join(File::SEPARATOR)
  end
end
