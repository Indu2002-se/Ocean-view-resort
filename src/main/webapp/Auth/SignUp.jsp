<%--
  Created by IntelliJ IDEA.
  User: vitha
  Date: 1/16/2026
  Time: 11:39 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Ocean View Resort</title>
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
            overflow-x: hidden;
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
            url('https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=1600') center/cover fixed;
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
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .back-link:hover {
            color: #c9a55c;
            transform: translateX(-5px);
        }

        .register-container {
            background: rgba(13, 13, 13, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 60px 50px;
            width: 90%;
            max-width: 520px;
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

        .register-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .register-subtitle {
            font-size: 11px;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: rgba(255, 255, 255, 0.5);
            margin-top: 10px;
        }

        .register-title {
            font-size: 28px;
            font-weight: 300;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-top: 20px;
            color: #fff;
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

        .form-group label .required {
            color: #c9a55c;
            margin-left: 3px;
        }

        .form-group input,
        .form-group select {
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

        .form-group select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23c9a55c' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 20px center;
            padding-right: 45px;
        }

        .form-group select option {
            background: #1a1a1a;
            color: #fff;
            padding: 10px;
        }

        .form-group input:focus,
        .form-group select:focus {
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
            user-select: none;
        }

        .password-toggle:hover {
            color: #c9a55c;
        }

        .password-strength {
            margin-top: 8px;
            display: none;
        }

        .password-strength.show {
            display: block;
        }

        .strength-bar {
            height: 4px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 2px;
            overflow: hidden;
            margin-bottom: 6px;
        }

        .strength-fill {
            height: 100%;
            width: 0;
            transition: all 0.3s;
            border-radius: 2px;
        }

        .strength-fill.weak {
            width: 33%;
            background: #ff6b6b;
        }

        .strength-fill.medium {
            width: 66%;
            background: #ffd93d;
        }

        .strength-fill.strong {
            width: 100%;
            background: #51cf66;
        }

        .strength-text {
            font-size: 10px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .strength-text.weak {
            color: #ff6b6b;
        }

        .strength-text.medium {
            color: #ffd93d;
        }

        .strength-text.strong {
            color: #51cf66;
        }

        .role-selection {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-bottom: 30px;
        }

        .role-card {
            background: rgba(255, 255, 255, 0.05);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }

        .role-card input[type="radio"] {
            display: none;
        }

        .role-card:hover {
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(201, 165, 92, 0.3);
        }

        .role-card input[type="radio"]:checked + .role-content {
            color: #c9a55c;
        }

        .role-card input[type="radio"]:checked ~ .role-card {
            border-color: #c9a55c;
            background: rgba(201, 165, 92, 0.1);
        }

        .role-card.selected {
            border-color: #c9a55c;
            background: rgba(201, 165, 92, 0.1);
        }

        .role-icon {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .role-name {
            font-size: 13px;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .role-description {
            font-size: 10px;
            color: rgba(255, 255, 255, 0.5);
            line-height: 1.4;
        }

        .terms {
            margin-bottom: 30px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }

        .terms input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #c9a55c;
            margin-top: 2px;
            flex-shrink: 0;
        }

        .terms label {
            font-size: 11px;
            color: rgba(255, 255, 255, 0.6);
            cursor: pointer;
            line-height: 1.6;
        }

        .terms label a {
            color: #c9a55c;
            text-decoration: none;
            transition: all 0.3s;
        }

        .terms label a:hover {
            text-decoration: underline;
        }

        .register-btn {
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

        .register-btn:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 15px 40px rgba(201, 165, 92, 0.5);
        }

        .register-btn:active:not(:disabled) {
            transform: translateY(0);
        }

        .register-btn:disabled {
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

        .login-link {
            text-align: center;
            font-size: 12px;
            color: rgba(255, 255, 255, 0.6);
        }

        .login-link a {
            color: #c9a55c;
            text-decoration: none;
            font-weight: 600;
            letter-spacing: 1px;
            transition: all 0.3s;
        }

        .login-link a:hover {
            text-decoration: underline;
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
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }

        .success-message {
            background: rgba(40, 167, 69, 0.1);
            border: 1px solid rgba(40, 167, 69, 0.3);
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 25px;
            font-size: 12px;
            color: #51cf66;
            display: none;
        }

        .success-message.show {
            display: block;
            animation: fadeInUp 0.4s;
        }

        .validation-message {
            font-size: 10px;
            color: #ff6b6b;
            margin-top: 6px;
            display: none;
        }

        .validation-message.show {
            display: block;
        }

        @media (max-width: 768px) {
            .register-container {
                padding: 40px 30px;
                margin: 20px;
            }

            .back-link {
                top: 20px;
                left: 20px;
            }

            .logo-text {
                font-size: 28px;
            }

            .register-title {
                font-size: 24px;
            }

            .role-selection {
                grid-template-columns: 1fr;
            }
        }

        /* Loading state */
        .register-btn.loading {
            position: relative;
            color: transparent;
            pointer-events: none;
        }

        .register-btn.loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            top: 50%;
            left: 50%;
            margin-left: -10px;
            margin-top: -10px;
            border: 2px solid #1a1a1a;
            border-radius: 50%;
            border-top-color: transparent;
            animation: spin 0.6s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<a href="//index.jsp" class="back-link">
    ← Back to Home
</a>

<div class="register-container">
    <div class="logo">
        <div class="logo-text">ocean<span>.view</span></div>
    </div>

    <div class="register-header">
        <div class="register-subtitle">Join Us Today</div>
        <h1 class="register-title">Create Account</h1>
    </div>

    <div class="error-message" id="errorMessage">
        Please check the form for errors.
    </div>

    <div class="success-message" id="successMessage">
        Registration successful! Redirecting to login...
    </div>

    <form id="registerForm" method="post" action="${pageContext.request.contextPath}/signup-servlet">
        <div class="form-group">
            <label for="username">Name <span class="required">*</span></label>
            <input type="text" id="username" name="username" placeholder="Enter UserName" required minlength="3">
            <div class="validation-message" id="usernameError">Username must be at least 3 characters</div>
        </div>

        <div class="form-group">
            <label for="email">Email Address <span class="required">*</span></label>
            <input type="email" id="email" name="email" placeholder="your.email@example.com" required>
            <div class="validation-message" id="emailError">Please enter a valid email address</div>
        </div>

        <div class="form-group">
            <label for="password">Password <span class="required">*</span></label>
            <input type="password" id="password" name="password" placeholder="Create a strong password" required minlength="6">
            <span class="password-toggle" id="togglePassword">Show</span>
            <div class="password-strength" id="passwordStrength">
                <div class="strength-bar">
                    <div class="strength-fill" id="strengthFill"></div>
                </div>
                <div class="strength-text" id="strengthText"></div>
            </div>
            <div class="validation-message" id="passwordError">Password must be at least 6 characters</div>
        </div>

        <div class="form-group">phone <span class="required">*</span></label>
            <input type="text" id="email" name="phoneNo" placeholder="phone number" required>

        </div>



        <div class="terms">
            <input type="checkbox" id="terms" name="terms" required>
            <label for="terms">
                I agree to the <a href="terms.jsp" target="_blank">Terms of Service</a> and
                <a href="privacy.jsp" target="_blank">Privacy Policy</a>
            </label>
        </div>

        <button type="submit" class="register-btn" id="registerBtn">Create Account</button>
    </form>

    <div class="divider">
        <span>Already have an account?</span>
    </div>

    <div class="login-link">
        <a href="Login.jsp">Sign In Instead</a>
    </div>
</div>

<script>
    // Password toggle functionality
    const togglePassword = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');
    const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
    const confirmPasswordInput = document.getElementById('confirmPassword');

    togglePassword.addEventListener('click', function() {
        const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordInput.setAttribute('type', type);
        this.textContent = type === 'password' ? 'Show' : 'Hide';
    });

    toggleConfirmPassword.addEventListener('click', function() {
        const type = confirmPasswordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        confirmPasswordInput.setAttribute('type', type);
        this.textContent = type === 'password' ? 'Show' : 'Hide';
    });

    // Password strength checker
    const passwordStrength = document.getElementById('passwordStrength');
    const strengthFill = document.getElementById('strengthFill');
    const strengthText = document.getElementById('strengthText');

    passwordInput.addEventListener('input', function() {
        const password = this.value;

        if (password.length === 0) {
            passwordStrength.classList.remove('show');
            return;
        }

        passwordStrength.classList.add('show');

        let strength = 0;
        if (password.length >= 6) strength++;
        if (password.length >= 10) strength++;
        if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
        if (/\d/.test(password)) strength++;
        if (/[^a-zA-Z\d]/.test(password)) strength++;

        strengthFill.className = 'strength-fill';
        strengthText.className = 'strength-text';

        if (strength <= 2) {
            strengthFill.classList.add('weak');
            strengthText.classList.add('weak');
            strengthText.textContent = 'Weak Password';
        } else if (strength <= 4) {
            strengthFill.classList.add('medium');
            strengthText.classList.add('medium');
            strengthText.textContent = 'Medium Password';
        } else {
            strengthFill.classList.add('strong');
            strengthText.classList.add('strong');
            strengthText.textContent = 'Strong Password';
        }
    });

    // Role selection
    const guestCard = document.getElementById('guestCard');
    const staffCard = document.getElementById('staffCard');
    const roleInputs = document.querySelectorAll('input[name="role"]');

    guestCard.classList.add('selected');

    roleInputs.forEach(input => {
        input.addEventListener('change', function() {
            guestCard.classList.remove('selected');
            staffCard.classList.remove('selected');

            if (this.value === 'GUEST') {
                guestCard.classList.add('selected');
            } else {
                staffCard.classList.add('selected');
            }
        });
    });

    // Form validation
    const registerForm = document.getElementById('registerForm');
    const registerBtn = document.getElementById('registerBtn');
    const errorMessage = document.getElementById('errorMessage');
    const successMessage = document.getElementById('successMessage');

    const usernameError = document.getElementById('usernameError');
    const emailError = document.getElementById('emailError');
    const passwordError = document.getElementById('passwordError');
    const confirmPasswordError = document.getElementById('confirmPasswordError');

    // Real-time validation
    document.getElementById('username').addEventListener('blur', function() {
        if (this.value.length < 3 && this.value.length > 0) {
            usernameError.classList.add('show');
            this.style.borderColor = 'rgba(220, 53, 69, 0.5)';
        } else {
            usernameError.classList.remove('show');
            this.style.borderColor = '';
        }
    });

    document.getElementById('email').addEventListener('blur', function() {
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(this.value) && this.value.length > 0) {
            emailError.classList.add('show');
            this.style.borderColor = 'rgba(220, 53, 69, 0.5)';
        } else {
            emailError.classList.remove('show');
            this.style.borderColor = '';
        }
    });

    document.getElementById('password').addEventListener('blur', function() {
        if (this.value.length < 6 && this.value.length > 0) {
            passwordError.classList.add('show');
            this.style.borderColor = 'rgba(220, 53, 69, 0.5)';
        } else {
            passwordError.classList.remove('show');
            this.style.borderColor = '';
        }
    });

    confirmPasswordInput.addEventListener('blur', function() {
        if (this.value !== passwordInput.value && this.value.length > 0) {
            confirmPasswordError.classList.add('show');
            this.style.borderColor = 'rgba(220, 53, 69, 0.5)';
        } else {
            confirmPasswordError.classList.remove('show');
            this.style.borderColor = '';
        }
    });

    // Form submission
    registerForm.addEventListener('submit', function(e) {
        e.preventDefault();

        // Hide previous messages
        errorMessage.classList.remove('show');
        successMessage.classList.remove('show');

        // Validate all fields
        let isValid = true;

        if (document.getElementById('username').value.length < 3) {
            usernameError.classList.add('show');
            isValid = false;
        }

        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(document.getElementById('email').value)) {
            emailError.classList.add('show');
            isValid = false;
        }

        if (passwordInput.value.length < 6) {
            passwordError.classList.add('show');
            isValid = false;
        }

        if (passwordInput.value !== confirmPasswordInput.value) {
            confirmPasswordError.classList.add('show');
            isValid = false;
        }

        if (!document.getElementById('terms').checked) {
            errorMessage.textContent = 'Please accept the Terms of Service and Privacy Policy';
            errorMessage.classList.add('show');
            isValid = false;
        }

        if (!isValid) {
            errorMessage.textContent = 'Please check the form for errors.';
            errorMessage.classList.add('show');
            return;
        }

        // If valid, submit the form
        registerBtn.classList.add('loading');
        registerBtn.disabled = true;

        // Submit to RegisterServlet
        this.submit();
    });

    // Input focus effects
    const inputs = document.querySelectorAll('input');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'translateY(-2px)';
        });

        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'translateY(0)';
        });
    });

    // Check for error parameters in URL
    window.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);

        if (urlParams.get('error') === 'exists') {
            errorMessage.textContent = 'Username or email already exists. Please try another.';
            errorMessage.classList.add('show');
        } else if (urlParams.get('error') === 'true') {
            errorMessage.textContent = 'Registration failed. Please try again.';
            errorMessage.classList.add('show');
        }
    });
</script>
</body>
</html>

