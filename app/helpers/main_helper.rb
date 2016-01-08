module MainHelper
  def xeditable? object = nil
    true
  end

  def current_path
    if request.path_info == '/'
      documents_path(format: :json)
    else
      request.path_info + '.json'
    end
  end

  def thumb_link thumb_path, link_path, height=64
    if File.exist? 'public/' + thumb_path
      link_to image_tag(thumb_path, height:height), link_path, target: '_blank'
    elsif File.extname(thumb_path) == '.doc'
      link_to image_tag('/Microsoft Office 2003 Word.png', height:height), link_path, target: '_blank'
    elsif File.extname(thumb_path) == '.docx'

      link_to image_tag('/Microsoft Office 2007 Word.png', height:height), link_path, target: '_blank'
    else
      link_to 'download', link_path, target: '_blank'
    end
  end
end
