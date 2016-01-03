class BindersController < ApplicationController
  def new
  end

  def create
    @binder = Binder.new(binder_params)
    @binder.save
  end

  def destroy
    params
    @binder = Binder.find(params[:binder][:binder_id])
    @binder.destroy
  end

  def source
    q = params[:q]
    @binders = Binder.where('title like :q', q: "%#{q}%")
    render json: @binders
  end

  private
  def binder_params
    params.require(:binder).permit(:title)
  end
end
