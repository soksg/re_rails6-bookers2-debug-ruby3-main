class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :delete]

  def create
    @user=User.new(user_params)
    @user.save
    redirect_to user_path(@user.id)
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @new_book = Book.new
  end

  def index
    @users = User.all
    @new_book = Book.new
    @book=Book.new
    @user=current_user
  end

  def edit
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path(@user), notice: "You have updated user successfully."
    else
      render "user_path(@user)"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
