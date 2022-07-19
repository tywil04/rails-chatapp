class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_user

    def set_user
        if current_user
            cookies[:current_user_email] = current_user.email
            cookies[:current_user_email2] = current_user.email
        end
    end
end
