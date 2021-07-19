package com.controller;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.dao.AuthorDao;
import com.daoimpl.AuthorDaoImpl;
import com.models.Author;

@Path("author")
public class AuthorController {

	AuthorDao authorDaoImpl = new AuthorDaoImpl();
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/create")
	public Author create(Author author) {
		authorDaoImpl.addAuthor(author);
		return author;
	}
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/update")
	public Author update(Author author) {
		authorDaoImpl.updateAuthor(author);
		return author;
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/delete/{id}")
	public String delete(@PathParam("id") Integer id) {
		Author author = authorDaoImpl.getAuthorById(id);
		
		Integer result = authorDaoImpl.deleteAuthor(author);
		if (result > 0) {
			return "success";
		}
		return "error";
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("getById/{id}")
	public Author getById(@PathParam("id") Integer id) {
		return authorDaoImpl.getAuthorById(id);
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/getAll")
	public List<Author> getAll(){
		return authorDaoImpl.getAllAuthor();
	}
}
