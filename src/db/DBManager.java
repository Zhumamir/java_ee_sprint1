package db;

import models.Task;

import java.util.ArrayList;
import java.util.Objects;

public class DBManager {
    public static ArrayList<Task> taskArrayList = new ArrayList<>();

    static {
        taskArrayList.add(new Task(1L, "Cоздать Веб приложение на JAVA EE", "Cоздать Веб приложение на JAVA EE", "23.01.2021", true));
        taskArrayList.add(new Task(2L, "Убраться дома и закупить продукты", "Убраться дома и закупить продукты", "25.01.2021", true));
        taskArrayList.add(new Task(3L, "Выполнить все домашние задания", "Выполнить все домашние задания", "28.01.2021", false));
        taskArrayList.add(new Task(4L, "Записаться на качку", "Записаться на качку", "12.12.2021", false));
        taskArrayList.add(new Task(5L, "Учить итальянский", "Учить итальянский", "01.05.2021", false));
    }

    public static void addTask(Task task){
        taskArrayList.add(task);
    } //этот метод добавляет новую задачу в список

    public static Task getTask(Long id){
        for (Task task : taskArrayList) {
            if (Objects.equals(task.getId(), id)) {
                return task;
            }
        }
        return null;
    } // этот метод возвращает объект задачи по id

    public static ArrayList getAllTasks(){
        return taskArrayList;
    } //этот метод возвращает список всех задач

    public static void deleteTask(Long id){
        for (int i = 0; i < taskArrayList.size(); i++) {
            if (taskArrayList.get(i).getId() == id) {
                taskArrayList.remove(i);
                break;
            }
        }
    } //этот метод удаляет задачу из списка по id

    public static Task updateTask(Task task) {
        for (int i = 0; i < taskArrayList.size(); i++) {
            if (task.getId() == taskArrayList.get(i).getId()) {
                taskArrayList.set(i, task);
                return task;
            }
        }
        return null;
    } //этот метод обновляет задачу
}
