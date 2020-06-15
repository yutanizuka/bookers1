class BooksController < ApplicationController
  def top
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    #ストロングパラメーターを使用
    @book = Book.new(book_params)
    #DBへ保存する
    if @book.save
      #show画面へリダイレクト
      redirect_to book_path(@book.id)
      flash[:notice] = "successfully"
    else
      @books = Book.all
      flash.now[:notice] = "error prohibited this book from being saved:"
      render "index"
    end
  end
  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(params[:id])
    else
      flash.now[:notice] = "error prohibited this book from being saved:"
      render "edit"
    end
  end

  def destroy
    @book =  Book.find params[:id]
    @book.destroy
    redirect_to books_path
  end
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
