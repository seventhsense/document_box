class DocToText
  def initialize(path)
    @file_path = File.dirname path
    @tmp_path = @file_path
    @extname = File.extname path
    @filename = File.basename path, @extname
  end
 
  def excute
    begin
      if @extname == '.doc'
        system("wvText #{doc_file_path} #{tmp_file_path}")
      else
        system("docx2txt #{doc_file_path} #{tmp_file_path}")
      end
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    ensure
      text = File.read tmp_file_path
      puts text
      File.delete tmp_file_path
    end
    return text
  end
 
  def doc_file_path
    [@file_path, @filename + @extname].join(File::SEPARATOR)
  end
 
  def tmp_file_path
    [@tmp_path, @filename + ".txt"].join(File::SEPARATOR)
  end
end
