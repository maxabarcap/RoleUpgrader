class UserController < ApplicationController
    def update_photo
        user = User.find(params[:id])
        user.upload_photo(params[:photo])
        redirect_to user_path(user)
    end
end
