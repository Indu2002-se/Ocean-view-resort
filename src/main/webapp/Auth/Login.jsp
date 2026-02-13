<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Ocean View Resort</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            background: #1a1a1a;
            color: #fff;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            padding: 40px 20px;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.8)),
            url('/assets/login.jpg') center/cover fixed;
            z-index: -1;
        }

        .back-link {
            position: fixed;
            top: 40px;
            left: 40px;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 12px;
            letter-spacing: 2px;
            text-transform: uppercase;
            transition: all 0.3s;
            z-index: 100;
        }

        .back-link:hover {
            color: #c9a55c;
            transform: translateX(-5px);
        }

        .login-container {
            background: rgba(13, 13, 13, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 60px 50px;
            width: 90%;
            max-width: 450px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            animation: fadeInUp 0.6s ease;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logo {
            text-align: center;
            margin-bottom: 15px;
        }

        .logo-text {
            font-size: 32px;
            font-weight: 700;
            color: #fff;
            letter-spacing: 1px;
            text-transform: lowercase;
        }

        .logo-text span {
            color: #c9a55c;
        }

        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .login-subtitle {
            font-size: 11px;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: rgba(255, 255, 255, 0.5);
            margin-top: 10px;
        }

        .login-title {
            font-size: 28px;
            font-weight: 300;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-top: 20px;
            color: #fff;
        }

        .error-message {
            background: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.3);
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 25px;
            font-size: 12px;
            color: #ff6b6b;
            display: none;
        }

        .error-message.show {
            display: block;
            animation: shake 0.4s;
        }

        @keyframes shake {

            0%,
            100% {
                transform: translateX(0);
            }

            25% {
                transform: translateX(-10px);
            }

            75% {
                transform: translateX(10px);
            }
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 12px;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            padding: 16px 20px;
            color: #fff;
            font-size: 14px;
            transition: all 0.3s;
            font-family: inherit;
        }

        .form-group input:focus {
            outline: none;
            border-color: #c9a55c;
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 0 3px rgba(201, 165, 92, 0.1);
        }

        .form-group input::placeholder {
            color: rgba(255, 255, 255, 0.3);
        }

        .password-toggle {
            position: absolute;
            right: 20px;
            top: 43px;
            cursor: pointer;
            color: rgba(255, 255, 255, 0.4);
            font-size: 12px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s;
        }

        .password-toggle:hover {
            color: #c9a55c;
        }

        .forgot-password {
            text-align: right;
            margin-bottom: 30px;
        }

        .forgot-password a {
            color: rgba(255, 255, 255, 0.5);
            text-decoration: none;
            font-size: 11px;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .forgot-password a:hover {
            color: #c9a55c;
        }

        .login-btn {
            width: 100%;
            padding: 18px;
            background: #c9a55c;
            color: #1a1a1a;
            border: none;
            border-radius: 30px;
            font-size: 12px;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 10px 30px rgba(201, 165, 92, 0.3);
        }

        .login-btn:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 15px 40px rgba(201, 165, 92, 0.5);
        }

        .login-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .divider {
            display: flex;
            align-items: center;
            margin: 30px 0;
            gap: 15px;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: rgba(255, 255, 255, 0.1);
        }

        .divider span {
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: rgba(255, 255, 255, 0.4);
        }

        .signup-link {
            text-align: center;
            font-size: 12px;
            color: rgba(255, 255, 255, 0.6);
        }

        .signup-link a {
            color: #c9a55c;
            text-decoration: none;
            font-weight: 600;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .login-container {
                padding: 40px 30px;
            }

            .back-link {
                top: 20px;
                left: 20px;
            }

            .logo-text {
                font-size: 28px;
            }

            .login-title {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>
<a href="index.jsp" class="back-link">← Back to Home</a>

<div class="login-container">
    <div class="logo">
        <div class="logo-text">ocean<span>.view</span></div>
    </div>

    <div class="login-header">
        <div class="login-subtitle">Welcome Back</div>
        <h1 class="login-title">Sign In</h1>
    </div>

    <div class="error-message" id="errorMessage">
        Invalid email or password. Please try again.
    </div>

    <form id="loginForm" method="post" action="${pageContext.request.contextPath}/login-servlet">
        <div class="form-group">
            <label for="email">Username</label>
            <input type="text" id="email" name="username" placeholder="username" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
            <span class="password-toggle" id="togglePassword">Show</span>
        </div>

        <div class="forgot-password">
            <a href="#">Forgot Password?</a>
        </div>

        <button type="submit" class="login-btn" id="loginBtn">Sign In</button>
    </form>

    <div class="divider">
        <span>Don't have an account?</span>
    </div>

    <div class="signup-link">
        <a href="signup.jsp">Create New Account</a>
    </div>
</div>

<script>
    // Password toggle
    const togglePassword = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');

    togglePassword.addEventListener('click', function () {
        const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordInput.setAttribute('type', type);
        this.textContent = type === 'password' ? 'Show' : 'Hide';
    });

    // Check for error and role in URL
    window.addEventListener('DOMContentLoaded', function () {
        const urlParams = new URLSearchParams(window.location.search);
        const errorMessage = document.getElementById('errorMessage');
        const role = urlParams.get('role');

        // Handle Role
        const validRoles = ['STAFF', 'MANAGER'];
        const roleInput = document.createElement('input');
        roleInput.type = 'hidden';
        roleInput.name = 'role';
        roleInput.value = role || 'GUEST'; // Default to GUEST
        document.getElementById('loginForm').appendChild(roleInput);

        const titleElement = document.querySelector('.login-subtitle');
        const signupLink = document.querySelector('.signup-link');
        const divider = document.querySelector('.divider');

        if (role && validRoles.includes(role.toUpperCase())) {
            titleElement.textContent = role.charAt(0).toUpperCase() + role.slice(1).toLowerCase() + ' Access';
            // Hide signup for non-guests
            if (signupLink) signupLink.style.display = 'none';
            if (divider) divider.style.display = 'none';
        }

        // Handle Errors
        if (urlParams.get('error') === 'invalid') {
            errorMessage.textContent = 'Invalid username or password. Please try again.';
            errorMessage.classList.add('show');
        } else if (urlParams.get('error') === 'true') {
            errorMessage.textContent = 'An error occurred. Please try again.';
            errorMessage.classList.add('show');
        }
    });

    // Form submission
    const loginForm = document.getElementById('loginForm');
    const loginBtn = document.getElementById('loginBtn');

    loginForm.addEventListener('submit', function () {
        loginBtn.disabled = true;
        loginBtn.textContent = 'Signing In...';
    });
</script>
</body>

</html>