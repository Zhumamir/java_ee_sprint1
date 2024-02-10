package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import db.DBManager;
import models.Task;

import java.io.IOException;

@WebServlet(value = "/detail")
public class DetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        Task task = DBManager.getTask(id);
        req.setAttribute("OneTask", task);
        req.getRequestDispatcher("details.jsp").forward(req,resp);
    }
}
