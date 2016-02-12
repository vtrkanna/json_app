class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def index
    redirect_to controller: 'users', action: 'contacts'
  end

  def create
    unless params[:contact][:user_id].blank?
      user = User.find_by_id(params[:contact][:user_id])
      if !user.accepted_contacts.where(email: params[:contact][:email]).blank?
        format.json { render json: {message: 'Contact already registered exists in your account'} }
      elsif !user.pending_contacts.where(email: params[:contact][:email]).blank?
        AppMailer.sign_up_email(@contact, "Resend contact request").deliver!
      else
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
    else
      format.json { render json: {message: 'Please provide user id.'} }
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end

end
