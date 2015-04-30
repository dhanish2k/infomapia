class UserController < ApplicationController
   http_basic_authenticate_with name:"dhanish2k", password: "secret";
  def index
     @users=User.all
  end

  def show
     @user=User.find_by_uid(params[:uid])
  end
end
