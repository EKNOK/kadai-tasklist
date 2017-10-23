class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper

  
  private
  
  def require_user_logged_in
      unless logged_in?
        redirect_to login_url
      end
  end
  
  def counts(user)
      @count_tasks = user.tasks.count
  end
  
  def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            flash[:danger] = "権限がありません"
            redirect_to root_url
        end
  end

end
