
<%@ page import="java.util.ArrayList" %>
<%@ page import="models.Task" %>
<%@ page import="db.DBManager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
</head>
<body>
<div class="container">
    <%@include file="navbar.jsp"%>
    <br><br>

    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
        + Добавить задание
    </button>
    <br><br>

    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Новое задание</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <!-- Форма для ввода данных -->
                    <form id="taskForm">
                        <div class="form-group">
                            <label for="name">Наименование:</label>
                            <input type="text" class="form-control" id="name" name="name">
                        </div>
                        <div class="form-group">
                            <label for="description">Описание:</label>
                            <textarea class="form-control" id="description" name="description"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="deadlineDate">Крайний срок:</label>
                            <input type="date" class="form-control" id="deadlineDate" name="deadlineDate">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Закрыть</button>
                    <button type="button" class="btn btn-primary" onclick="addTask()">Добавить</button>
                </div>
            </div>
        </div>
    </div>

    <table class="table table-striped">
        <thead>
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Наименование</th>
            <th scope="col">Крайник срок</th>
            <th scope="col">Выполнено</th>
            <th scope="col" width="10%">Детали</th>
        </tr>
        </thead>
        <tbody>

        <%
            ArrayList<Task> itemArrayList = DBManager.getAllTasks();
        %>


        <%
            for(Task task:itemArrayList){
                String statusText = task.isStatus() ? "Да" : "Нет";
        %>

        <tr>
            <td><%=task.getId()%></td>
            <td><%=task.getName()%></td>
            <td><%=task.getDeadlineDate()%></td>
            <td><%=statusText%></td>
            <td>
                <a href="${pageContext.request.contextPath}/detail?id=<%=task.getId()%>" class="btn btn-dark">DETAILS</a>
            </td>
        </tr>

        <%
            }
        %>
        </tbody>
    </table>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>

    function addTask() {
        var name = document.getElementById('name').value;
        var description = document.getElementById('description').value;
        var deadlineDateStr = document.getElementById('deadlineDate').value;
        var deadlineDate = new Date(deadlineDateStr);
        var formattedDeadlineDate = (deadlineDate.getDate() < 10 ? '0' : '') + deadlineDate.getDate() + '.' +
            ((deadlineDate.getMonth() + 1) < 10 ? '0' : '') + (deadlineDate.getMonth() + 1) + '.' +
            deadlineDate.getFullYear();

        var requestData = {
            name: name,
            description: description,
            deadlineDate: formattedDeadlineDate
        };

        $.ajax({
            type: "POST",
            url: "/java_ee_sprint1_Web_exploded/add",
            data: requestData,
            success: function(response) {
                window.location.href = "home.jsp";
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    }

</script>
</body>
</html>
