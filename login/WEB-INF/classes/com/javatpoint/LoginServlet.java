package com.javatpoint;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String password = request.getParameter("password");

        if (name == null || password == null) {
            out.print("Error: Please provide both username and password.");
            return;
        }

        if ("admin123".equals(password)) {
            out.print("You are successfully logged in!");
            Cookie ck = new Cookie("name", name);
            ck.setMaxAge(3600);
            response.addCookie(ck);
            response.sendRedirect("ProfileServlet");
        } else {
            out.print("Sorry, username or password error!");
            response.sendRedirect("login.html");
        }
        out.close();
    }
}
