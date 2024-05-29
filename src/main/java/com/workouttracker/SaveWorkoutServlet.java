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

@WebServlet("/SaveWorkoutServlet")
public class SaveWorkoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve workout data from request parameters
        String date = request.getParameter("date");
        String type = request.getParameter("type");
        int duration = Integer.parseInt(request.getParameter("duration"));
        int calories = Integer.parseInt(request.getParameter("calories"));

        // Insert workout data into the database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/workout_tracker", "root",
                    "satya123");
            String sql = "INSERT INTO workoutsdone (date, type, duration, calories_burned) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, date);
            preparedStatement.setString(2, type);
            preparedStatement.setInt(3, duration);
            preparedStatement.setInt(4, calories);
            preparedStatement.executeUpdate();
            preparedStatement.close();
            connection.close();
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
