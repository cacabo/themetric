class ReferralsController < ApplicationController
  before_action :super_admin

  def index
    @referrals = Referral.all;
  end

  def create
    @referral = Referral.new(email_params)

    if @referral.save
      flash[:notice] = "Thanks for adding your referred email to the list!"
      redirect_to referrals_path
    else
      flash[:alert] = "There was an issue adding your referred email."
      redirect_to referrals_path
    end
  end

  def destroy
    @referral = Referral.find(params[:id])
    @referral.destroy
    flash[:notice] = "Referred email removed successfully."
    redirect_to root_path
  end

  private

  def email_params
    params.require(:referral).permit(:email)
  end

  def super_admin
    unless current_admin and (current_admin.super or current_admin.id == 1)
      flash[:alert] = "You must be a super admin to perform this"
      redirect_to(root_url)
    end
  end
end
