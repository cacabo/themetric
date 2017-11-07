class AdminsController < ApplicationController
  before_action :correct_admin, only: [:edit, :update]
  before_action :super_admin, only: [:super, :unsuper]

  def show
    @admin = Admin.friendly.exists?(params[:id]) ? Admin.friendly.find(params[:id]) : nil

    if current_admin and @admin
      @articles = @admin.articles
    else
      @articles = @admin.articles.where(published: true)
    end
  end

  def info
    if not current_admin
      flash[:alert] = "You must be logged in to see this page."
      redirect_to root_path
    end
  end

  def edit
    @admin = Admin.friendly.find(params[:id])
  end

  def update
    @admin = Admin.friendly.find(params[:id])

    if @admin.update(admin_params)
      flash[:notice] = "Admin information updated successfully."
      redirect_to @admin
    else
      flash[:alert] = "There was an issue updating your admin information."
      render 'edit'
    end
  end

  def super
    @admin = Admin.friendly.find(params[:id])
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
    @admin = Admin.friendly.find(params[:id])
    @admin.super = false

    if @admin.save
      flash[:notice] = "Admin demoted to regular admin."
      redirect_to @admin
    else
      flash[:alert] = "Failed to demote admin to regular admin."
      redurect_to @admin
    end
  end

  def guest
    @admin = Admin.friendly.find(params[:id])
    @admin.isGuest = true

    if @admin.save
      flash[:notice] = "Admin changed to guest."
      redirect_to @admin
    else
      flash[:alert] = "Failed to change to guest."
      redurect_to @admin
    end
  end

  def unguest
    @admin = Admin.friendly.find(params[:id])
    @admin.isGuest = false

    if @admin.save
      flash[:notice] = "Admin no longer guest."
      redirect_to @admin
    else
      flash[:alert] = "Failed to change away from guest."
      redurect_to @admin
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :role, :bio, :image, :email, :facebook, :twitter, :github, :website, :instagram, :linkedin, :location)
  end

  def correct_admin
    unless current_admin and ((current_admin.id.to_i == Admin.friendly.find(params[:id]).id.to_i) or (current_admin.super or current_admin.id == 1))
      flash[:alert] = "Only a super admin or the user of focus can edit this information."
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
