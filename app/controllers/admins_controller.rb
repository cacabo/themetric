class AdminsController < ApplicationController
  def show
    @admin = Admin.exists?(params[:id]) ? Admin.find(params[:id]) : nil
  end

  def index
    @admins = Admin.all
  end
end
