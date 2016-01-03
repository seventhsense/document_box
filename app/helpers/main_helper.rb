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
end
