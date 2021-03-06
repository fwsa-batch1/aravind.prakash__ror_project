class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if current_user
      if current_user.role == "owner"
        redirect_to orders_path
      else
        redirect_to menu_index_path
      end
    else
      render "index"
    end
  end
end
