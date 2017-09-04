class EmailsController < ApplicationController
  before_action :authenticate_admin!, except: [:delete]

  def new
    @email = current_admin.articles.build
  end

  def create
    @email = current_admin.articles.build(article_params)

    if @email.save
      flash[:notice] = "Email submitted successfully."
      redirect_to @email
    else
      flash[:alert] = "There was an issue adding your email."
      redirect_to root_url
    end
  end


  def destroy
    @email = Email.find(params[:id])
    @email.destroy
    flash[:notice] = "Email removed successfully."
    redirect_to root_path
  end
end
