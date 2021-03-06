class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]

    # The above code is equivalent to:
    # if session[user_id]
    # 	@current_user = User.find_by(id: session[:user_id])
    # else
    # 	@current_user = false
    # end
  end
  helper_method :current_user

  def authenticate_user!
    if !current_user
      flash[:danger] = "You must be logged in to do that!"
      redirect_to '/login' unless current_user
    end
  end

  def authenticate_admin!

    if !(current_user && current_user.admin)
      flash[:danger] = "You must be an admin to do that!"
      redirect_to '/'
    end

  end

  def categories            # this is what gets called, in our application.html.erb on line # 60.
    @categories = Category.all
  end
  helper_method :categories # this is what allows us to actually call the method. if it is named differently than
                            # the method on line # 22, we will get an error.
end