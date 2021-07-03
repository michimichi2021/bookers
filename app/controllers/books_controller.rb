class BooksController < ApplicationController
  
  def index
     @book=Book.new
     @books=Book.all
  end
  
  def create
    # １. データを新規登録するためのインスタンス作成
    @book=Book.new(book_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
      flash[:notice] = "Book was successfully created."
    # ３. トップ画面へリダイレクト
      redirect_to "/books/#{@book.id}"
    else
      @books = Book.all.order(id: :asc)
      render 'index'
    end
  end
  
  def show
    @book=Book.find(params[:id])
  end
  
  def edit
    @book=Book.find(params[:id])
  end
  
  def update
    @book=Book.find(params[:id])
    
    
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      
      redirect_to "/books/#{@book.id}"
    else
      
      render 'edit'
    end
  end
  
  def destroy
    book=Book.find(params[:id])
    
    if book.destroy
      flash[:notice] = "Book was successfully destroyed."
      redirect_to books_path
    else
      render action: :index
    end
      
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  
end
