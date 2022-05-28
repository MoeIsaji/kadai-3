class UsersController < ApplicationController

 def edit
    @user = User.find(params[:id])
    if @user == current_user
    render "edit"
    else
     redirect_to user_path(current_user)
    end
 end

  def index
    @user = current_user
    @book = Book.new
    @users =User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def create
    @user = User.new(user_params)
   if @usre.save
    redirect_to usre_path(@user.id)
   else
    render :new
   end
  end

  def update
     @user = User.find(params[:id])
     @user.update(user_params)
    if  @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(current_user)
    else
     flash[:alart] = "is too short (minimum is 2 characters)"
     @users = User.all
     render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
