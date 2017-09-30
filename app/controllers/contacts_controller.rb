class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end

    def create
        @contact = Contact.new(params[:contact])
        @contact.request = request
        if @contact.deliver
            flash.now[:notice] = 'Message sent successfully'
        else
            flash.now[:alert] = 'Failed to send message.'
            render :new
        end
    end
end
