package servlets;

import db.DBManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Task;

import java.io.IOException;

@WebServlet(value = "/update")
public class UpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String deadlineDate = req.getParameter("deadlineDate");
        String status = req.getParameter("status");
        Task task = new Task();
        task.setId(Long.valueOf(id));
        task.setName(name);
        task.setDescription(description);
        task.setDeadlineDate(deadlineDate);
        task.setStatus(Boolean.parseBoolean(status));
        DBManager.updateTask(task);
        resp.sendRedirect("/java_ee_sprint1_Web_exploded/home");
    }
}
