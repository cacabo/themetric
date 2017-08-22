class AdminsController < ApplicationController
  before_action :correct_admin, only: [:edit, :update]
  def show
    @admin = Admin.exists?(params[:id]) ? Admin.find(params[:id]) : nil
  end

  def index
    @admins = Admin.all
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])

    if @admin.update(admin_params)
      redirect_to @admin
    else
      render 'edit'
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :bio, :image, :email)
  end

  def correct_admin
    unless current_admin.id.to_i == params[:id].to_i
      flash[:alert] = "You can only edit your own information"
      redirect_to(root_url)
    end
  end
end
