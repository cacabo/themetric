class AdminsController < ApplicationController
  before_action :correct_admin, only: [:edit, :update]
  before_action :super_admin, only: [:super, :unsuper]

  def show
    @admin = Admin.exists?(params[:id]) ? Admin.find(params[:id]) : nil
  end

  def info
    if not current_admin
      flash[:alert] = "You must be logged in to see this page."
      redirect_to root_path
    end
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
      flash[:notice] = "Admin information updated successfully."
      redirect_to @admin
    else
      flash[:alert] = "There was an issue updating your admin information."
      render 'edit'
    end
  end

  def super
    @admin = Admin.find(params[:id])
    @admin.super = true

    if @admin.save
      flash[:notice] = "Admin promoted to super admin."
      redirect_to @admin
    else
      flash[:alert] = "Failed to promote admin to super."
      redurect_to @admin
    end
  end

  def unsuper
    @admin = Admin.find(params[:id])
    @admin.super = false

    if @admin.save
      flash[:notice] = "Admin demoted to regular admin."
      redirect_to @admin
    else
      flash[:alert] = "Failed to demote admin to regular admin."
      redurect_to @admin
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :role, :bio, :image, :email, :facebook, :twitter, :github, :website, :instagram, :linkedin)
  end

  def correct_admin
    unless current_admin and current_admin.id.to_i == params[:id].to_i
      flash[:alert] = "You can only edit your own information."
      redirect_to(root_url)
    end
  end

  def super_admin
    unless current_admin and (current_admin.super or current_admin.id == 1)
      flash[:alert] = "You must be a super admin to perform this"
      redirect_to(root_url)
    end
  end
end
