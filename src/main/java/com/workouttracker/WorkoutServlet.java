package com.workouttracker;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/WorkoutServlet")
public class WorkoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form data
        String date = request.getParameter("date");
        String workoutType = request.getParameter("type");
        int duration = Integer.parseInt(request.getParameter("duration"));
        int caloriesBurned = Integer.parseInt(request.getParameter("caloriesBurned"));

        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection with the correct credentials
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/workout_tracker", "root",
                    "satya123");

            // Insert data into the database
            String sql = "SELECT* FROM workouts (date, workout_type, duration, calories_burned) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, date);
            statement.setString(2, workoutType);
            statement.setInt(3, duration);
            statement.setInt(4, caloriesBurned);
            statement.executeUpdate();

            // Close the connection
            statement.close();
            connection.close();

            // Redirect to dashboard.jsp
            response.sendRedirect("dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
