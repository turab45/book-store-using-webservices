package com.controller;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.dao.AuthorDao;
import com.dao.BookDao;
import com.daoimpl.AuthorDaoImpl;
import com.daoimpl.BookDaoImpl;
import com.google.gson.Gson;
import com.models.Author;
import com.models.Book;

@Path("book")
public class BookController {
	BookDao bookDaoImpl = new BookDaoImpl();
	AuthorDao authorDaoImpl = new AuthorDaoImpl();
	Gson gson = new Gson();
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/create")
	public Book create(Book book) {
		System.out.println("Book = "+book);
		bookDaoImpl.addBook(book);
		return book;
	}
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/create2")
	public Book create2(Book book) {
		Author author = authorDaoImpl.getAuthorByName(book.getAuthor().getName());
		book.setAuthor(author);
		System.out.println("Book = "+book);
		bookDaoImpl.addBook(book);
		return book;
	}
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/update")
	public Book update(Book book) {
		
		bookDaoImpl.updateBook(book);
		return book;
	}
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/update2")
	public Book update2(Book book) {
		Author author = authorDaoImpl.getAuthorByName(book.getAuthor().getName());
		book.setAuthor(author);
		System.out.println("Book = "+book);
		bookDaoImpl.updateBook(book);
		return book;
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/delete/{id}")
	public String delete(@PathParam("id") Integer id) {
		Book book = bookDaoImpl.getBookById(id);
		Integer result = bookDaoImpl.deleteBook(book);
		if (result > 0) {
			return gson.toJson("success");
		}
		return gson.toJson("record not found");
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/getById/{id}")
	public Book getById(@PathParam("id") Integer id) {
		
		return bookDaoImpl.getBookById(id);
	}
	
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/getAll")
	public List<Book> getAll(){
		return bookDaoImpl.getAllBook();
	}
}
