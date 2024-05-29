<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.workouttracker.LogWorkout" %>
<meta http-equiv="refresh" content="10"> 

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Workout Tracker</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <a class="navbar-brand" href="#">Workout Tracker</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="workout.jsp">Goto Workouts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logworkout.jsp">Log Workout</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Dashboard Content -->
    <div class="container" style="padding-top: 80px;">
        <h1 class="text-center">Welcome, <%= session.getAttribute("username") %>!</h1>
        <p class="text-center">Here are the details of your workouts:</p>
        
        <!-- Workout Details -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Workout Type</th>
                    <th>Duration (minutes)</th>
                    <th>Calories Burned</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<LogWorkout> workouts = (List<LogWorkout>) session.getAttribute("workouts");
                    if (workouts != null && !workouts.isEmpty()) {
                        for (LogWorkout workout : workouts) {
                %>
                <tr>
                    <td><%= workout.getDate() %></td>
                    <td><%= workout.getWorkoutType() %></td>
                    <td><%= workout.getDuration() %></td>
                    <td><%= workout.getCaloriesBurned() %></td>
                </tr>
                <% 
                        }
                    } else { 
                %>
                <tr>
                    <td colspan="4" class="text-center">No workout details found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Link to log a new workout -->
        <div class="d-flex justify-content-center">
            <a href="logworkout.jsp" class="btn btn-primary mr-3" style="height: 40px;">Log New Workout</a>
            <form action="/workouttracker/DeleteAllWorkoutsServlet" method="post">
                <button type="submit" class="btn btn-danger" style="height: 40px;">Delete All Workouts</button>
            </form>
        </div>


    </div>

    

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
