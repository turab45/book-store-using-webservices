package com.controller;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.dao.AuthorDao;
import com.dao.BookDao;
import com.daoimpl.AuthorDaoImpl;
import com.daoimpl.BookDaoImpl;
import com.models.Book;

@Path("book")
public class BookController {
	BookDao bookDaoImpl = new BookDaoImpl();
	AuthorDao authorDaoImpl = new AuthorDaoImpl();
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/create")
	public Book create(Book book) {
		System.out.println("Book = "+book);
		bookDaoImpl.addBook(book);
		return book;
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/getAll")
	public List<Book> getAll(){
		return bookDaoImpl.getAllBook();
	}
}
