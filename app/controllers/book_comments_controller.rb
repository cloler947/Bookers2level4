class BookCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@book = Book.find(params[:book_id])
		@book_comment = @book.book_comments.new(book_comment_params)
		@book_comment.user_id = current_user.id
		if @book_comment.save
			redirect_to books_path(@book), notice:"successfully created comments!"
		else
			@book_comments = BookComment.where(book_id: @book.id)
      		render '/books/show'
		end
	end

	def destroy
		@book_comment = BookComment.find(params[:book_id])
		if @book_comment.user != current_user
			redirect_back(fallback_location: books_path)
		end
		@book_comment.destroy
		redirect_back fallback_location: books_path, notice:"successfully delete comments!"
	end

	private
		def book_comment_params
			params.require(:book_comment).permit(:user_id, :book_id, :comment)
		end
end
