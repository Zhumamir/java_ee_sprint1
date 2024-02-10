package servlets;

import db.DBManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Task;

import java.io.IOException;

@WebServlet(value = "/add")
public class AddServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String deadlineDate = req.getParameter("deadlineDate");
        Task task = new Task();
        task.setId((long) (DBManager.taskArrayList.size() + 1));
        task.setName(name);
        task.setDescription(description);
        task.setDeadlineDate(deadlineDate);
        task.setStatus(false);
        DBManager.addTask(task);
        resp.sendRedirect("/java_ee_sprint1_Web_exploded/home");
    }
}
