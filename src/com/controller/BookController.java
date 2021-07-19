package com.controller;

import com.dao.AuthorDao;
import com.dao.BookDao;
import com.daoimpl.AuthorDaoImpl;
import com.daoimpl.BookDaoImpl;

public class BookController {
	BookDao bookDaoImpl = new BookDaoImpl();
	AuthorDao authorDaoImpl = new AuthorDaoImpl();
}
