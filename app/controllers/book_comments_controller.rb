class BookCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@comment = current_user.book_comments.new(book_comment_params)
		@comment.book_id = @book.id
		if @comment.save
			redirect_back fallback_location: books_path, notice:"successfully created comments!"
		else
			@book = Book.find_by(params[:id])
			@book_comment = BookComment.new
			@user = @book.user
			@comment.book_id = @book.id
			redirect_back fallback_location: books_path, notice: "errors prohibited this obj from being saved:"
		end
	end

	def destroy
		@book = Book.find(params[:book_id])
		@user = @book.user
		@comment = current_user.book_comments.find_by(id: params[:id], book_id: params[:book_id])
		@comment.destroy
		redirect_back fallback_location: books_path, notice:"successfully delete comments!"
	end

	private
		def book_comment_params
			params.require(:book_comment).permit(:user_id, :book_id, :comment)
		end
end
