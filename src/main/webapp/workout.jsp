<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Workouts - Workout Tracker</title>
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
                    <a class="nav-link" href="logworkout.jsp">Log Workout</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="deleteworkout.jsp">Delete Workout</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Workout List -->
    <div class="container" style="padding-top: 80px;">
        <h1 class="text-center">Workouts</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Workout Type</th>
                    <th>Duration (minutes)</th>
                    <th>Calories Burned</th>
                    <th>Timer</th>
                </tr>
            </thead>
            <tbody id="workoutTableBody">
                <%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement" %>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/workout_tracker", "root", "satya123");
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM workouts");

                        while (rs.next()) {
                            String date = rs.getString("date");
                            String workoutType = rs.getString("type");
                            int duration = rs.getInt("duration");
                            int caloriesBurned = rs.getInt("calories_burned");
                %>
                <tr>
                    <td><%= date %></td>
                    <td><%= workoutType %></td>
                    <td><%= duration %></td>
                    <td><%= caloriesBurned %></td>
                    <td>
                        <button class="btn btn-success start-btn" data-date="<%= date %>" data-type="<%= workoutType %>" data-duration="<%= duration %>" data-calories="<%= caloriesBurned %>" onclick="startTimer(this)">Start</button>
                        <button class="btn btn-warning stop-btn" onclick="stopTimer(this)">Stop</button>
                        <button class="btn btn-danger reset-btn" onclick="resetTimer(this)">Reset</button>
                        <span class="timer">0:00</span>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Timer Functions -->
    <script>
        function startTimer(button) {
            var durationStr = button.getAttribute('data-duration');
            var duration = parseInt(durationStr);
            if (!isNaN(duration)) {
                var timerSpan = button.parentElement.querySelector('.timer');
                var currentTimer = duration * 60;
                displayTime(timerSpan, currentTimer);
                var timer = setInterval(function() {
                    currentTimer--;
                    displayTime(timerSpan, currentTimer);
                    if (currentTimer <= 0) {
                        clearInterval(timer);
                        saveWorkoutDone(button);
                    }
                }, 1000);
                button.setAttribute('data-timer', timer);
            } else {
                console.error('Invalid duration: ' + durationStr);
            }
        }

        function stopTimer(button) {
            var startBtn = button.parentElement.querySelector('.start-btn');
            var timer = startBtn.getAttribute('data-timer');
            clearInterval(timer);
        }

        function resetTimer(button) {
            var timerSpan = button.parentElement.querySelector('.timer');
            timerSpan.textContent = '0:00';
            var startBtn = timerSpan.parentElement.querySelector('.start-btn');
            clearInterval(startBtn.getAttribute('data-timer'));
            startBtn.removeAttribute('data-timer');
        }

        function displayTime(timerSpan, time) {
            var minutes = Math.floor(time / 60);
            var seconds = time % 60;
            timerSpan.textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
        }

        function saveWorkoutDone(button) {
    var date = button.getAttribute('data-date');
    var type = button.getAttribute('data-type');
    var duration = button.getAttribute('data-duration');
    var calories = button.getAttribute('data-calories');

    // AJAX request to save the workout
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "SaveWorkoutServlet", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                // Successful response
                window.location.href = 'DashboardServlet';
            } else {
                // Error handling
                console.error('Error saving workout:', xhr.responseText);
            }
        }
    };
    var data = "date=" + encodeURIComponent(date) +
               "&type=" + encodeURIComponent(type) +
               "&duration=" + encodeURIComponent(duration) +
               "&calories=" + encodeURIComponent(calories);
    xhr.send(data);
}

    </script>
</body>
</html>
