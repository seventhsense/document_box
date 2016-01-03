class MainController < ApplicationController
  def index
    sSearch = params[:sSearch]
    iDisplayStart = params[:iDisplayStart].to_i
    iDisplayLength = params[:iDisplayLength].to_i
    iSortCol_0 = params[:iSortCol_0].to_i
    sSortDir_0 = params[:sSortDir_0]
 
    per_page = iDisplayLength > 0 ? iDisplayLength : 10
    page = iDisplayStart/per_page + 1
 
    columns = %w["label" "name" "author" "date" "content"]
    sort_column = columns[iSortCol_0]
    sort_direction = sSortDir_0 == "desc" ? "desc" : "asc"
    @display_documents = Document
      .where("label like :search or name like :search or author like :search or content like :search", search: "%#{sSearch}%")
      .order("#{sort_column} #{sort_direction}")
    @documents = @display_documents.page(page).per(per_page)
    @sEcho = params[:sEcho].to_i
  end

  def show
    @document = Document.find(params[:id])
  end

  def create
    @document = Document.new document_params

    if @document.save
      render :json => { head: :ok }
    else
      render :json => { head: :unprocessable_entity}
    end
  end

  def update
    @document = Document.find(params[:id])
    logger.debug params[:document]
    logger.debug document_params
    if @document.update(document_params)
      render :json => { head: :ok }
    end
  end

  private
  def document_params
    params.require(:document).permit(:label, :name, :author,  :file, :date, :content)
  end
end
