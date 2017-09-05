class EmailsController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  before_action :super_admin, only: [:destroy]

  def index
    @emails = Email.all;
  end

  def create
    @email = Email.new(email_params)

    if @email.save
      flash[:notice] = "Thanks for adding your email to our list!"
      redirect_to root_url
    else
      flash[:alert] = "There was an issue adding your email."
      redirect_to root_url
    end
  end

  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    flash[:notice] = "Email removed successfully."
    redirect_to emails_path
  end

  private

  def email_params
    params.require(:email).permit(:email)
  end

  def super_admin
    unless current_admin and (current_admin.super or current_admin.id == 1)
      flash[:alert] = "You must be a super admin to perform this"
      redirect_to(root_url)
    end
  end
end
