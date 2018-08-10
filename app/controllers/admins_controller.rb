class AdminsController < ApplicationController
  # Method validations
  before_action :correct_or_super_admin, only: [:edit, :update, :destroy]
  before_action :super_admin, only: [:super, :unsuper, :guest, :unguest]

  # Show a given admin's information
  def show
    @admin = Admin.friendly.exists?(params[:id]) ? Admin.friendly.find(params[:id]) : nil

    if @admin.present?
      if current_admin
        @articles = @admin.articles
      else
        @articles = @admin.articles.where(published: true)
      end
    end
  end

  # List all admins
  def index
    if not current_admin
      flash[:alert] = "You must be logged in to see this page."
      redirect_to root_path
    end

    @admins = Admin.all.order('name ASC')
  end

  # If the user is logged in, display relevant information about how to use the
  # website
  def info
    if not current_admin
      flash[:alert] = "You must be logged in to see this page."
      redirect_to root_path
    end
  end

  # Edit an admin's information
  def edit
    @admin = Admin.friendly.find(params[:id])
  end

  # Update an admin's information
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

  # Delete an admin's account
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    flash[:notice] = "Successfully deleted admin."
    redirect_to root_path
  end

  # Make an admin a super admin
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

  # Make an admin no longer a super admin
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

  # Make an admin a guest contributor
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

  # Make an admin no longer a guest contributor
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

  # Find all fields for the admin
  def admin_params
    params.require(:admin).permit(:name, :role, :bio, :image, :email, :facebook, :twitter, :github, :website, :instagram, :linkedin, :location, :quote)
  end

  # Ensure that the passed in ID corresponds to the admin or that the admin is
  # a super admin
  def correct_or_super_admin
    unless (
      current_admin and (
        (current_admin.id.to_i == Admin.friendly.find(params[:id]).id.to_i) or
        (current_admin.super or current_admin.id == 1)
      )
    )
      flash[:alert] = "Only a super admin or the user of focus can edit this information."
      redirect_to(root_url)
    end
  end

  # Ensure that the admin is a super admin
  def super_admin
    unless current_admin and (current_admin.super or current_admin.id == 1)
      flash[:alert] = "You must be a super admin to perform this"
      redirect_to(root_url)
    end
  end
end
