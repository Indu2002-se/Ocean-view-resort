<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort - Luxury Beachside Hotel in Galle</title>
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
        }

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 140px;
            height: 100vh;
            background: #0d0d0d;
            z-index: 1000;
            padding: 40px 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: #fff;
            letter-spacing: 1px;
            text-transform: lowercase;
        }

        .logo span {
            color: #c9a55c;
        }

        .section-number {
            font-size: 64px;
            font-weight: 300;
            color: rgba(255, 255, 255, 0.1);
            line-height: 1;
            margin-top: 30px;
        }

        .nav-dots {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 50px;
        }

        .dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            cursor: pointer;
            transition: all 0.3s;
        }

        .dot.active {
            background: #c9a55c;
            transform: scale(1.4);
        }

        .social-links {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-bottom: 30px;
        }

        .social-links a {
            color: rgba(255, 255, 255, 0.5);
            font-size: 18px;
            transition: all 0.3s;
            text-decoration: none;
        }

        .social-links a:hover {
            color: #c9a55c;
        }

        .main-content {
            margin-left: 140px;
        }

        .top-nav {
            position: fixed;
            top: 0;
            right: 0;
            left: 140px;
            background: rgba(13, 13, 13, 0.95);
            backdrop-filter: blur(10px);
            padding: 30px 80px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 999;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .location {
            color: rgba(255, 255, 255, 0.6);
            font-size: 12px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .nav-menu {
            display: flex;
            gap: 50px;
            list-style: none;
        }

        .nav-menu a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 13px;
            letter-spacing: 2px;
            text-transform: uppercase;
            transition: all 0.3s;
            position: relative;
        }

        .nav-menu a:hover,
        .nav-menu a.active {
            color: #c9a55c;
        }

        .nav-menu a::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 1px;
            background: #c9a55c;
            transition: width 0.3s;
        }

        .nav-menu a:hover::after {
            width: 100%;
        }

        .hero-section {
            position: relative;
            height: 100vh;
            background: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.6)),
            url('${pageContext.request.contextPath}/assets/hero.jpg') center/cover;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.3);
        }

        .hero-content {
            position: relative;
            z-index: 10;
            text-align: center;
            max-width: 900px;
            padding: 0 40px;
        }

        .hero-label {
            font-size: 11px;
            letter-spacing: 4px;
            text-transform: uppercase;
            color: #c9a55c;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .hero-title {
            font-size: 72px;
            font-weight: 300;
            letter-spacing: 8px;
            text-transform: uppercase;
            margin-bottom: 30px;
            line-height: 1.2;
        }

        .hero-description {
            font-size: 15px;
            line-height: 1.8;
            color: rgba(255, 255, 255, 0.8);
            max-width: 600px;
            margin: 0 auto 40px;
            font-weight: 300;
        }

        .cta-btn {
            display: inline-block;
            padding: 18px 50px;
            background: #c9a55c;
            color: #1a1a1a;
            text-decoration: none;
            border-radius: 30px;
            font-size: 12px;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 10px 30px rgba(201, 165, 92, 0.3);
        }

        .cta-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(201, 165, 92, 0.5);
        }

        .about-section {
            padding: 120px 80px;
            background: #0d0d0d;
        }

        .section-title {
            font-size: 42px;
            font-weight: 300;
            letter-spacing: 4px;
            text-transform: uppercase;
            text-align: center;
            margin-bottom: 80px;
        }

        .section-title span {
            color: #c9a55c;
        }

        .about-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 80px;
            max-width: 1200px;
            margin: 0 auto;
            align-items: center;
        }

        .about-text h3 {
            font-size: 28px;
            font-weight: 400;
            margin-bottom: 30px;
            line-height: 1.4;
        }

        .about-text p {
            font-size: 14px;
            line-height: 1.9;
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 20px;
        }

        .specialization {
            margin-top: 60px;
        }

        .spec-title {
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 15px;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-size: 12px;
        }

        .spec-item {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 20px;
            padding: 20px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        .spec-icon {
            width: 40px;
            height: 40px;
            background: rgba(201, 165, 92, 0.1);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .spec-label {
            font-size: 13px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: rgba(255, 255, 255, 0.9);
        }

        .about-image {
            height: 500px;
            background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)),
            url('https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800') center/cover;
            border-radius: 8px;
            position: relative;
            overflow: hidden;
        }

        .projects-section {
            padding: 120px 0;
            background: #1a1a1a;
        }

        .projects-header {
            text-align: center;
            margin-bottom: 80px;
        }

        .projects-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 0;
        }

        .project-card {
            position: relative;
            height: 600px;
            overflow: hidden;
            cursor: pointer;
            background: #0d0d0d;
        }

        .project-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to bottom, transparent, rgba(0, 0, 0, 0.9));
            z-index: 1;
            transition: all 0.5s;
        }

        .project-card:hover::before {
            background: linear-gradient(to bottom, transparent, rgba(0, 0, 0, 0.7));
        }

        .project-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s;
        }

        .project-card:hover img {
            transform: scale(1.1);
        }

        .project-info {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 40px;
            z-index: 2;
        }

        .project-category {
            font-size: 11px;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 10px;
        }

        .project-title {
            font-size: 20px;
            font-weight: 400;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .project-label {
            position: absolute;
            left: 40px;
            top: 50%;
            transform: translateY(-50%) rotate(-90deg);
            transform-origin: left center;
            font-size: 11px;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: rgba(255, 255, 255, 0.4);
        }

        .project-nav {
            position: absolute;
            bottom: 40px;
            right: 40px;
            display: flex;
            gap: 20px;
            z-index: 2;
        }

        .project-nav button {
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            cursor: pointer;
            transition: all 0.3s;
            backdrop-filter: blur(10px);
        }

        .project-nav button:hover {
            background: #c9a55c;
            border-color: #c9a55c;
            color: #1a1a1a;
        }

        .stats-section {
            padding: 100px 80px;
            background: #0d0d0d;
            text-align: center;
        }

        .stats-number {
            font-size: 180px;
            font-weight: 700;
            line-height: 1;
            background: linear-gradient(135deg, #c9a55c 0%, #f4e5c3 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 20px;
        }

        .stats-text {
            font-size: 16px;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: rgba(255, 255, 255, 0.7);
        }

        .stats-subtext {
            font-size: 13px;
            color: rgba(255, 255, 255, 0.5);
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-top: 10px;
        }

        .clients-section {
            padding: 100px 80px;
            background: #1a1a1a;
        }

        .clients-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 60px;
            max-width: 1200px;
            margin: 60px auto;
        }

        .client-logo {
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0.4;
            transition: all 0.3s;
            height: 60px;
        }

        .client-logo:hover {
            opacity: 1;
        }

        .client-logo img {
            max-width: 120px;
            filter: grayscale(100%) brightness(2);
        }

        .view-more-btn {
            display: block;
            margin: 60px auto 0;
            padding: 15px 40px;
            background: transparent;
            border: 1px solid rgba(201, 165, 92, 0.3);
            color: #c9a55c;
            border-radius: 30px;
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s;
        }

        .view-more-btn:hover {
            background: #c9a55c;
            color: #1a1a1a;
        }

        .contact-section {
            padding: 120px 80px;
            background: #0d0d0d;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: 1fr 1.5fr;
            gap: 100px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .contact-info h3 {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 15px;
            line-height: 1.8;
        }

        .contact-info p {
            font-size: 13px;
            color: rgba(255, 255, 255, 0.5);
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .contact-form {
            display: grid;
            gap: 30px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            background: transparent;
            border: none;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 15px 0;
            color: #fff;
            font-size: 14px;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-bottom-color: #c9a55c;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        .submit-btn {
            justify-self: end;
            padding: 18px 50px;
            background: #c9a55c;
            color: #1a1a1a;
            border: none;
            border-radius: 30px;
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(201, 165, 92, 0.4);
        }

        footer {
            background: #000;
            padding: 60px 80px;
            margin-left: 140px;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .footer-logo {
            font-size: 28px;
            font-weight: 700;
            color: #fff;
        }

        .footer-nav {
            display: flex;
            gap: 40px;
            list-style: none;
        }

        .footer-nav a {
            color: rgba(255, 255, 255, 0.5);
            text-decoration: none;
            font-size: 11px;
            letter-spacing: 2px;
            text-transform: uppercase;
            transition: all 0.3s;
        }

        .footer-nav a:hover {
            color: #c9a55c;
        }

        @media (max-width: 1200px) {
            .projects-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .clients-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 80px;
                padding: 30px 15px;
            }

            .main-content {
                margin-left: 80px;
            }

            .top-nav {
                left: 80px;
                padding: 20px 30px;
            }

            .nav-menu {
                display: none;
            }

            .hero-title {
                font-size: 42px;
            }

            .about-grid,
            .contact-grid {
                grid-template-columns: 1fr;
            }

            .projects-grid {
                grid-template-columns: 1fr;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .clients-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            footer {
                margin-left: 80px;
            }

            .footer-content {
                flex-direction: column;
                gap: 30px;
            }
        }
        /* ... existing styles ... */

        /* Role Selection Modal */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(8px);
            z-index: 2000;
            display: none;
            justify-content: center;
            align-items: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .modal-overlay.active {
            display: flex;
            opacity: 1;
        }

        .role-modal {
            background: #1a1a1a;
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            width: 90%;
            max-width: 800px;
            text-align: center;
            transform: translateY(30px);
            transition: transform 0.3s ease;
            box-shadow: 0 20px 60px rgba(0,0,0,0.5);
            position: relative;
        }

        .modal-overlay.active .role-modal {
            transform: translateY(0);
        }

        .close-modal {
            position: absolute;
            top: 20px;
            right: 20px;
            background: transparent;
            border: none;
            color: rgba(255, 255, 255, 0.5);
            font-size: 24px;
            cursor: pointer;
            transition: color 0.3s;
        }

        .close-modal:hover {
            color: #c9a55c;
        }

        .role-options {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
            margin-top: 40px;
        }

        .role-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 15px;
            padding: 40px 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }

        .role-card:hover {
            background: rgba(201, 165, 92, 0.1);
            border-color: #c9a55c;
            transform: translateY(-10px);
        }

        .role-icon {
            font-size: 48px;
            color: rgba(255, 255, 255, 0.7);
            transition: all 0.3s;
        }

        .role-card:hover .role-icon {
            color: #c9a55c;
            transform: scale(1.1);
        }

        .role-title {
            font-size: 16px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: #fff;
            font-weight: 500;
        }

        .role-desc {
            font-size: 12px;
            color: rgba(255, 255, 255, 0.5);
            line-height: 1.6;
        }

        @media (max-width: 768px) {
            .role-options {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="sidebar">
    <div>
        <div class="logo">ocean<span>.view</span></div>
        <div class="section-number">01</div>
        <div class="nav-dots">
            <div class="dot active"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>
        </div>
    </div>
    <div class="social-links">
        <a href="#">fb</a>
        <a href="#">tw</a>
        <a href="#">in</a>
        <a href="#">ig</a>
    </div>
</div>

<div class="main-content">
    <nav class="top-nav">
        <div class="location">📍  Sri Lanka</div>
        <ul class="nav-menu">
            <li><a href="#home" class="active">Home</a></li>
            <li><a href="#about">About Us</a></li>
            <li><a href="#rooms">Rooms</a></li>
            <li><a href="#blog">Blog</a></li>
            <li><a href="#contact">Contact</a></li>
        </ul>
    </nav>

    <section class="hero-section" id="home">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <div class="hero-label">Premium · Beachside · Experience</div>
            <h1 class="hero-title">Luxury Ocean View<br>Rest Your Day</h1>
            <p class="hero-description">
                Ocean View Resort is the architecture of a new generation, a building
                which not only takes into consideration the natural beauty of space
                but also in the dimension of time and communication.
            </p>
            <a href="Auth/SignUp.jsp" class="cta-btn">Sign Up Here</a>
            <div style="margin-top: 20px;">
                <a href="#" onclick="openRoleModal(event)" style="color: rgba(255, 255, 255, 0.7); text-decoration: none; font-size: 13px; letter-spacing: 2px; text-transform: uppercase; transition: all 0.3s;">Already have an account? <span style="color: #c9a55c;">Sign In</span></a>
            </div>
        </div>
    </section>

    <section class="about-section" id="about">
        <h2 class="section-title">About <span>Ocean.View</span></h2>
        <div class="about-grid">
            <div class="about-text">
                <h3>we turn your vacation into an unforgettable experience.</h3>
                <p>
                    For each project we establish relationships with partners who we know
                    will help us create added value for your project. As well as bringing
                    together the public and private sectors, we make sector-overarching
                    links to gather knowledge and to learn from each other.
                </p>
                <p>
                    The way we undertake projects is based on permanently applying values
                    that reinforce each other: socio-cultural value, experiential value,
                    and environmental value. Our relationships with stakeholders are based
                    on the exchange of these values.
                </p>

                <div class="specialization">
                    <div class="spec-title">Our Specialization:</div>
                    <div class="spec-item">
                        <div class="spec-icon">🏨</div>
                        <div class="spec-label">Luxury Accommodations</div>
                    </div>
                    <div class="spec-item">
                        <div class="spec-icon">🛏️</div>
                        <div class="spec-label">Premium Room Service</div>
                    </div>
                    <div class="spec-item">
                        <div class="spec-icon">📋</div>
                        <div class="spec-label">Digital Reservation System</div>
                    </div>
                </div>
            </div>
            <div class="about-image"></div>
        </div>
    </section>

    <section class="projects-section" id="rooms">
        <div class="projects-header">
            <h2 class="section-title">Our <span>Room Types</span></h2>
        </div>
        <div class="projects-grid">
            <div class="project-card">
                <img src="assets/Luxury%20Suite.jpg" alt="Deluxe Suite">
                <div class="project-label">Luxury Suite</div>
                <div class="project-info">
                    <div class="project-category">Premium Accommodation</div>
                    <div class="project-title">Deluxe Ocean<br>Suite</div>
                </div>
            </div>

            <div class="project-card">
                <img src="assets/Standard%20Comfort.jpg" alt="Standard Room">
                <div class="project-label">Comfort Room</div>
                <div class="project-info">
                    <div class="project-category">Standard Comfort</div>
                    <div class="project-title">Premium<br>Standard Room</div>
                </div>
            </div>

            <div class="project-card">
                <img src="assets/beachfront.jpg" alt="Ocean View">
                <div class="project-label">Ocean Panorama</div>
                <div class="project-info">
                    <div class="project-category">Beachfront Living</div>
                    <div class="project-title">Ocean View<br>Paradise</div>
                </div>
                <div class="project-nav">
                    <button>← PREV</button>
                    <button>NEXT →</button>
                </div>
            </div>
        </div>
    </section>

    <section class="stats-section">
        <div class="stats-number">250+</div>
        <div class="stats-text">Successful Reservations</div>
        <div class="stats-subtext">Every Month in Galle</div>
    </section>

    <section class="clients-section">
        <h2 class="section-title">Our <span>Partners</span></h2>
        <div class="clients-grid">
            <div class="client-logo">
                <span style="font-size: 18px; letter-spacing: 3px; color: rgba(255,255,255,0.4);">BOOKING.COM</span>
            </div>
            <div class="client-logo">
                <span style="font-size: 18px; letter-spacing: 3px; color: rgba(255,255,255,0.4);">EXPEDIA</span>
            </div>
            <div class="client-logo">
                <span style="font-size: 18px; letter-spacing: 3px; color: rgba(255,255,255,0.4);">AGODA</span>
            </div>
            <div class="client-logo">
                <span style="font-size: 18px; letter-spacing: 3px; color: rgba(255,255,255,0.4);">HOTELS.COM</span>
            </div>
            <div class="client-logo">
                <span style="font-size: 18px; letter-spacing: 3px; color: rgba(255,255,255,0.4);">AIRBNB</span>
            </div>
            <div class="client-logo">
                <span style="font-size: 18px; letter-spacing: 3px; color: rgba(255,255,255,0.4);">TRIVAGO</span>
            </div>
            <div class="client-logo">
                <span style="font-size: 18px; letter-spacing: 3px; color: rgba(255,255,255,0.4);">KAYAK</span>
            </div>
            <div class="client-logo">
                <span style="font-size: 18px; letter-spacing: 3px; color: rgba(255,255,255,0.4);">TRIPADVISOR</span>
            </div>
        </div>
        <button class="view-more-btn">View All Partners</button>
    </section>

    <section class="contact-section" id="contact">
        <h2 class="section-title">Get <span>In Touch</span></h2>
        <div class="contact-grid">
            <div class="contact-info">
                <h3>+94 91 224 3355</h3>
                <h3>+94 91 287 6522</h3>
                <h3>info@oceanviewgalle.com</h3>
                <p>
                    Beach Road, Fort, Galle 80000<br>
                    Sri Lanka
                </p>
            </div>
            <form class="contact-form">
                <div class="form-row">
                    <div class="form-group">
                        <input type="text" placeholder="Name" required>
                    </div>
                    <div class="form-group">
                        <input type="email" placeholder="Email" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <input type="text" placeholder="Phone" required>
                    </div>
                    <div class="form-group">
                        <input type="text" placeholder="Company">
                    </div>
                </div>
                <div class="form-group">
                    <textarea placeholder="Message" required></textarea>
                </div>
                <button type="submit" class="submit-btn">Send Message</button>
            </form>
        </div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-logo">ocean.view</div>
            <ul class="footer-nav">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About Us</a></li>
                <li><a href="#rooms">Rooms</a></li>
                <li><a href="#blog">Blog</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </div>
    </footer>
</div>

<script>
    // Smooth scrolling
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Navigation dots update on scroll
    const sections = document.querySelectorAll('section');
    const dots = document.querySelectorAll('.dot');

    window.addEventListener('scroll', () => {
        let current = '';
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            if (scrollY >= (sectionTop - sectionHeight / 3)) {
                current = section.getAttribute('id');
            }
        });

        dots.forEach((dot, index) => {
            dot.classList.remove('active');
            if (index === Array.from(sections).findIndex(section => section.getAttribute('id') === current)) {
                dot.classList.add('active');
            }
        });
    });

    // Update active navigation link on scroll
    const navLinks = document.querySelectorAll('.nav-menu a');

    window.addEventListener('scroll', () => {
        let current = '';

        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            if (scrollY >= (sectionTop - 200)) {
                current = section.getAttribute('id');
            }
        });

        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === `#${current}`) {
                link.classList.add('active');
            }
        });
    });

    // Section number update based on scroll
    const sectionNumber = document.querySelector('.section-number');
    let currentSection = 1;

    window.addEventListener('scroll', () => {
        const scrollPosition = window.scrollY;
        const windowHeight = window.innerHeight;

        sections.forEach((section, index) => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;

            if (scrollPosition >= sectionTop - windowHeight / 2 &&
                scrollPosition < sectionTop + sectionHeight - windowHeight / 2) {
                currentSection = index + 1;
            }
        });

        sectionNumber.textContent = String(currentSection).padStart(2, '0');
    });

    // Navigation dots click to scroll
    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            if (sections[index]) {
                sections[index].scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Form submission handler
    const contactForm = document.querySelector('.contact-form');
    if (contactForm) {
        contactForm.addEventListener('submit', (e) => {
            e.preventDefault();

            // Get form data
            const formData = new FormData(contactForm);

            // Here you would typically send the data to a server
            // For now, we'll just show a success message
            alert('Thank you for your message! We will get back to you soon.');

            // Reset form
            contactForm.reset();
        });
    }

    // Project navigation buttons
    const prevBtn = document.querySelector('.project-nav button:first-child');
    const nextBtn = document.querySelector('.project-nav button:last-child');

    if (prevBtn && nextBtn) {
        prevBtn.addEventListener('click', () => {
            // Add your previous project logic here
            console.log('Previous project');
        });

        nextBtn.addEventListener('click', () => {
            // Add your next project logic here
            console.log('Next project');
        });
    }

    // Parallax effect for hero section
    const heroSection = document.querySelector('.hero-section');
    if (heroSection) {
        window.addEventListener('scroll', () => {
            const scrolled = window.scrollY;
            heroSection.style.transform = `translateY(${scrolled * 0.5}px)`;
        });
    }

    // Add scroll reveal animation
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -100px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe all project cards and spec items
    document.querySelectorAll('.project-card, .spec-item').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });

    // Top navigation background on scroll
    const topNav = document.querySelector('.top-nav');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 100) {
            topNav.style.background = 'rgba(13, 13, 13, 0.98)';
        } else {
            topNav.style.background = 'rgba(13, 13, 13, 0.95)';
        }
    });

    // Input focus effects
    const inputs = document.querySelectorAll('input, textarea');
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'translateY(-2px)';
        });

        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'translateY(0)';
        });
    });
</script>
<!-- Role Selection Modal -->
<div class="modal-overlay" id="roleModal">
    <div class="role-modal">
        <button class="close-modal" onclick="closeRoleModal()">×</button>
        <h2 class="section-title" style="margin-bottom: 10px; font-size: 32px;">Choose Your <span>Role</span></h2>
        <p style="color: rgba(255,255,255,0.6); font-size: 14px;">Select your access level to proceed to the login dashboard</p>

        <div class="role-options">
            <div class="role-card" onclick="selectRole('GUEST')">
                <div class="role-icon">👤</div>
                <div class="role-title">Guest</div>
                <div class="role-desc">Book rooms, view reservations, and manage your stay profile.</div>
            </div>

            <div class="role-card" onclick="selectRole('STAFF')">
                <div class="role-icon">🛎️</div>
                <div class="role-title">Staff</div>
                <div class="role-desc">Manage check-ins, reservations, and guest requests.</div>
            </div>

            <div class="role-card" onclick="selectRole('MANAGER')">
                <div class="role-icon">💼</div>
                <div class="role-title">Manager</div>
                <div class="role-desc">Administrative access, reporting, and system oversight.</div>
            </div>
        </div>
    </div>
</div>

<script>
    function openRoleModal(e) {
        if(e) e.preventDefault();
        const modal = document.getElementById('roleModal');
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeRoleModal() {
        const modal = document.getElementById('roleModal');
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }

    function selectRole(role) {
        // Redirect to Login.jsp with the selected role
        window.location.href = 'Auth/Login.jsp?role=' + role;
    }

    // Close modal when clicking outside
    document.getElementById('roleModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeRoleModal();
        }
    });
</script>
</body>
</html>