package com.controller;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.dao.UserDao;
import com.daoimpl.UserDaoImpl;
import com.google.gson.Gson;
import com.models.User;

@Path("user")
public class UserController {
	
	UserDao userDaoImpl = new UserDaoImpl();
	Gson gson = new Gson();
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/register")
	public String register(User user) {
		Integer result = userDaoImpl.addUser(user);
		if (result > 0) {
			return gson.toJson("success");
		}
		return gson.toJson("error");
	}
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/login")
	public String login(User user) {
		user = userDaoImpl.getUserByEmailAndPassword(user.getUserName(), user.getPassword());
		
		if (user != null) {
			return gson.toJson("success");
		}
		return gson.toJson("error");
	}
}
