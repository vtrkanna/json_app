class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        AppMailer.sign_up_email(@contact, "Verify your email").deliver!
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: {message: 'Contact was successfully created.'} }
      else
        format.json { render json: @contact.errors, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email)
  end

end
