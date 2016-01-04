class PdfToText
  def initialize(path)
    @file_path = File.dirname path
    @tmp_path = @file_path
    @filename = File.basename path, ".pdf"
    @extname = File.extname path
  end
 
  def excute
    return unless @extname == '.pdf'
    begin
      system("pdftotext -enc UTF-8 #{pdf_file_path} #{tmp_file_path}")
      # raise 'A test exception.'
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    ensure
      text = File.read tmp_file_path
      File.delete tmp_file_path
    end
    return text
  end
 
  def pdf_file_path
    [@file_path, @filename + ".pdf"].join(File::SEPARATOR)
  end
 
  def tmp_file_path
    [@tmp_path, @filename + ".txt"].join(File::SEPARATOR)
  end
 
end
