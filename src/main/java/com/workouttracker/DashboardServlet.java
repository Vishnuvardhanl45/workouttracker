package com.workouttracker;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<LogWorkout> workouts = new ArrayList<>();

        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/workout_tracker", "root",
                    "satya123");

            // Create SQL statement to get all workouts
            String sql = "SELECT id, date, type, duration, calories_burned FROM workoutsdone ORDER BY id DESC";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();

            // Process the result set
            while (resultSet.next()) {
                LogWorkout workout = new LogWorkout();
                workout.setDate(resultSet.getString("date"));
                workout.setWorkoutType(resultSet.getString("type"));
                workout.setDuration(resultSet.getInt("duration"));
                workout.setCaloriesBurned(resultSet.getInt("calories_burned"));
                workouts.add(workout);
            }

            // Close the connection
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set the workouts attribute for the session if there are workouts
        HttpSession session = request.getSession();
        session.setAttribute("workouts", workouts);

        // Forward to the dashboard.jsp page
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
