class UsersController < ApplicationController

  def login
  end

  def signup
    @user = User.new
  end

  def verify_login
    email = params[:login][:email]
    password = params[:login][:password]
    @user = User.where("UPPER(email) = UPPER(?)", email.upcase.strip).first
    unless @user
      message = 'Username does not exist'
      redirect_to login
    else
      if @user.password.blank?
        message = 'User must set password before first login'
        redirect_to login
      elsif @user.password != params[:login][:password]
        message = 'Password is incorrect'
        redirect_to login
      else
        cookies[:login] = {:value => 'true'}
        expiry_time = 1.day.from_now
        cookies[:user_id] = {:value => @user.id, :expires => expiry_time}
        session[:user_id] = @user.id
        render json: {message: 'success', redirect_url: "/users/contacts"}
      end
    end
  end

  def show
  end

  def logout
    reset_session
    redirect_to root_url
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        AppMailer.invite_user(@user, "Verify your email").deliver!
        format.json { render json: {message: 'User was successfully created.', redirect_url: "/users/contacts"} }
        format.html { redirect_to :login, notice: 'User was successfully created.' }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  def contacts
    @user = User.find_by_id(session[:user_id])
    @contacts = @user.contacts
  end

  private
  def user_params
    params.require(:login).permit(:name, :email, :password)
  end

end
