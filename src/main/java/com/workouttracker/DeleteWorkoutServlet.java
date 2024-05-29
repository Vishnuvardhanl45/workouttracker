package com.workouttracker;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteWorkoutServlet")
public class DeleteWorkoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/workout_tracker", "root", "satya123");

            // Get parameters from the request
            String date = request.getParameter("date");
            String type = request.getParameter("type");
            int duration = Integer.parseInt(request.getParameter("duration"));
            int caloriesBurned = Integer.parseInt(request.getParameter("caloriesBurned"));

            // Construct the SQL query to delete the workout entry
            String sql = "DELETE FROM workouts WHERE date = ? AND type = ? AND duration = ? AND calories_burned = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, date);
            pstmt.setString(2, type);
            pstmt.setInt(3, duration);
            pstmt.setInt(4, caloriesBurned);

            pstmt.executeUpdate();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("workout.jsp");
    }
}
