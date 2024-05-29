<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to Workout Tracker</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            padding-top: 56px;
        }
        .welcome-section {
            padding: 60px 0;
            text-align: center;
        }
        .welcome-section h1 {
            font-size: 3rem;
            margin-bottom: 20px;
        }
        .welcome-section p {
            font-size: 1.2rem;
            margin-bottom: 40px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <a class="navbar-brand" href="#">Workout Tracker</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
    </nav>
    <br><br><br>
    <!-- Welcome Section -->
    <div class="container welcome-section">
        <h1>Welcome to Workout Tracker</h1>
        <p>Your personal fitness assistant to help you track your workouts and achieve your fitness goals.</p>
        <a href="register.html" class="btn btn-primary btn-lg mr-2">Get Started</a>
        <a href="login.html" class="btn btn-secondary btn-lg">Login</a>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
