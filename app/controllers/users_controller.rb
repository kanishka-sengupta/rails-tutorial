class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :require_user, only: [:edit,:update]
    before_action :require_same_user, only: [:edit, :update]
    def show
        #@articles=@user.articles
        @articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def new
        @user=User.new
    end

    def edit
    end
    
    def index
        #@users=User.all
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def create
        @user=User.new(user_params)
        if(@user.save)
            session[:user_id]=@user.id
            flash[:notice]="Welcome to Alpha Blog, #{@user.username}. You have succesfully registered."
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def update
        if @user.update(user_params)
            flash[:notice]="Your account was updated"
            redirect_to users_path
        else
            render 'edit'
        end
    end


    private 

    def user_params
        params.require(:user).permit(:username,:email,:password)
    end

    def set_user
        @user=User.find(params[:id])
    end

    def require_same_user
        if current_user != @user
            flash[:alert] ="You can only edit your own profile"
            redirect_to @user
        end
    end
    
end