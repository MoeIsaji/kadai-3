class BooksController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
  end

  def new
    @book = Book.new
    @books = Book.all
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def update
     @book = Book.find(params[:id])
      if @book.update(book_params)
       flash[:notice] = "successfully."
       redirect_to book_path(@book.id)
      else
      flash[:alert] = "error"
      @books = Book.all
      render :edit
      end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:notice] = "successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"
  end

  def edit
     @book = Book.find(params[:id])
  end


  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
