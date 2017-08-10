class AdminsController < ApplicationController
  def show
    @admin = Admin.find(params[:id]) if Admin.exists? id: :id
  end

  def index
    @admins = Admin.all
  end
end
