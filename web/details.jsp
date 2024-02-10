<%@ page import="models.Task" %>
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
    <%
        Task task = (Task) request.getAttribute("OneTask");
    %>
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div id="taskForm">
                <div class="form-group" style="margin-bottom: 20px;">
                    <label for="name">Наименование:</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%=task.getName()%>">
                </div>
                <div class="form-group" style="margin-bottom: 20px;">
                    <label for="description">Описание:</label>
                    <textarea class="form-control" id="description" name="description"><%=task.getDescription()%></textarea>
                </div>
                <div class="form-group" style="margin-bottom: 20px;">
                    <label for="deadlineDate">Крайний срок:</label>
                    <input type="date" class="form-control" id="deadlineDate" name="deadlineDate">
                </div>
                <div class="form-group" style="margin-bottom: 20px;">
                    <label for="status">Выполнено:</label>
                    <select class="form-control" id="status" name="status">
                        <option value="true" <%= task.isStatus() ? "selected" : "" %>>Да</option>
                        <option value="false" <%= !task.isStatus() ? "selected" : "" %>>Нет</option>
                    </select>


                </div>
            </div>
            <br><br>
            <div style="display: flex; justify-content: center;">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="updateTask(<%= task.getId() %>)">
                    Сохранить
                </button>
                <div style="margin-left: 10px;">
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal1" onclick="deleteTask(<%= task.getId() %>)">
                        Удалить
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    var dateString = '<%= task.getDeadlineDate() %>';

    var dateParts = dateString.split(".");
    var dateObject = new Date(dateParts[2], dateParts[1] - 1, dateParts[0]);

    var formattedDate = dateObject.getFullYear() + "-" + ('0' + (dateObject.getMonth() + 1)).slice(-2) + "-" + ('0' + dateObject.getDate()).slice(-2);

    document.getElementById('deadlineDate').value = formattedDate;

    function updateTask(taskId) {
        var id = taskId;
        var name = document.getElementById('name').value;
        var description = document.getElementById('description').value;
        var deadlineDateStr = document.getElementById('deadlineDate').value;

        // Преобразуем строку в объект Date
        var deadlineDate = new Date(deadlineDateStr);

        // Получаем день, месяц и год из объекта Date
        var formattedDeadlineDate = (deadlineDate.getDate() < 10 ? '0' : '') + deadlineDate.getDate() + '.' +
            ((deadlineDate.getMonth() + 1) < 10 ? '0' : '') + (deadlineDate.getMonth() + 1) + '.' +
            deadlineDate.getFullYear();

        var status = document.getElementById('status').value;
        status = (status === "yes") ? true : false;

        var requestData = {
            id: id,
            name: name,
            description: description,
            deadlineDate: formattedDeadlineDate,
            status: status
        };

        // Выполнение AJAX-запроса на сервер
        $.ajax({
            type: "POST",
            url: "/java_ee_sprint1_Web_exploded/update", // URL вашего сервлета
            data: requestData, // Данные для отправки на сервер
            success: function(response) { // Функция, вызываемая при успешном выполнении запроса
                // Перенаправление на страницу home.jsp
                window.location.href = "home.jsp";
            },
            error: function(xhr, status, error) { // Функция, вызываемая при ошибке выполнения запроса
                console.error(xhr.responseText); // Вывод ошибки в консоль браузера
            }
        });
    }

    function deleteTask(taskId) {
        // Выполнение AJAX-запроса на сервер для удаления задачи
        $.ajax({
            type: "POST",
            url: "/java_ee_sprint1_Web_exploded/delete", // URL вашего сервлета для удаления задачи
            data: { id: taskId }, // Передаем ID задачи для удаления
            success: function(response) { // Функция, вызываемая при успешном выполнении запроса
                // Перенаправление на страницу home.jsp
                window.location.href = "home.jsp";
            },
            error: function(xhr, status, error) { // Функция, вызываемая при ошибке выполнения запроса
                console.error(xhr.responseText); // Вывод ошибки в консоль браузера
            }
        });
    }



</script>

</body>

</html>