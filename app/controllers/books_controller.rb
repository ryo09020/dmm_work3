class BooksController < ApplicationController
  before_action :is_matching_user, only: [:edit, :update]
  def index
    @new_book = Book.new
    @books=Book.all
    @user=User.find(current_user.id)

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
    flash[:notice] ="You have created book successfully."
    redirect_to book_path(@book.id)
   else
    @books=Book.all
    @user=User.find(current_user.id)
    @new_book = @book
    render :index
   end

  end

  def edit
    @book=Book.find(params[:id])
  end

  def show
    @new_book=Book.new
    @book=Book.find(params[:id])
    @user=@book.user
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id),notice: 'You have updated book successfully.'

    else
      render :edit
    end

  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_user


    unless Book.find(params[:id]).user_id == current_user.id
      redirect_to books_path
    end
  end

end
