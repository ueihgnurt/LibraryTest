module BooksHelper
    def get_quantity book_id
		if Book.find(book_id).quantity > 0
			return Book.find(book_id).quantity  
		else
			return 0;
		end
	end
end
