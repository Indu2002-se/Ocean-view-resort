<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort — Staff & Management Portal</title>
    <meta name="description" content="Internal staff and management portal for Ocean View Resort, Galle, Sri Lanka. Authorized personnel only.">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300;1,400&family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after {
            margin: 0; padding: 0; box-sizing: border-box;
        }

        :root {
            --gold: #c9a55c;
            --gold-light: #e8c98a;
            --gold-pale: rgba(201,165,92,0.10);
            --dark: #0a0a0c;
            --dark-mid: #111114;
            --dark-panel: #0e0e11;
            --dark-card: #141418;
            --text: #fff;
            --text-muted: rgba(255,255,255,0.55);
            --text-faint: rgba(255,255,255,0.22);
            --accent-staff: #5c8ec9;
            --accent-staff-glow: rgba(92,142,201,0.15);
            --accent-mgr: #c97a5c;
            --accent-mgr-glow: rgba(201,122,92,0.15);
        }

        html, body {
            height: 100%;
            overflow: hidden;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: var(--dark);
            color: var(--text);
        }

        /* ── FULL-SCREEN BG ── */
        .bg-layer {
            position: fixed;
            inset: 0;
            z-index: 0;
        }

        .bg-image {
            position: absolute;
            inset: 0;
            background: url('assets/hero.jpg') center/cover no-repeat;
            transform: scale(1.05);
            animation: slowZoom 22s ease-in-out infinite alternate;
        }

        @keyframes slowZoom {
            from { transform: scale(1.05); }
            to   { transform: scale(1.14); }
        }

        .bg-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(
                160deg,
                rgba(10,10,12,0.92) 0%,
                rgba(10,10,12,0.82) 40%,
                rgba(10,10,12,0.88) 100%
            );
        }

        /* grain */
        .bg-grain {
            position: absolute;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E");
            pointer-events: none;
        }

        /* ambient glow orbs */
        .bg-orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(120px);
            opacity: 0.08;
            pointer-events: none;
        }
        .bg-orb--gold {
            width: 500px; height: 500px;
            background: var(--gold);
            top: -100px; right: -100px;
        }
        .bg-orb--blue {
            width: 400px; height: 400px;
            background: var(--accent-staff);
            bottom: -60px; left: -60px;
        }

        /* ── CONTENT WRAPPER ── */
        .portal {
            position: relative;
            z-index: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 40px 24px;
        }

        /* ── LOGO ── */
        .logo {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 14px;
        }

        .logo-mark {
            width: 48px; height: 48px;
            border: 1.5px solid var(--gold);
            border-radius: 50%;
            display: grid; place-items: center;
            font-size: 22px;
            background: rgba(201,165,92,0.06);
        }

        .logo-text {
            font-family: 'Cormorant Garamond', serif;
            font-size: 24px;
            font-weight: 400;
            letter-spacing: 3px;
            text-transform: uppercase;
        }

        .logo-text span { color: var(--gold); }

        /* ── HEADER ── */
        .portal-header {
            text-align: center;
            margin-bottom: 52px;
        }

        .portal-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 7px 20px;
            border: 1px solid rgba(201,165,92,0.25);
            border-radius: 100px;
            font-size: 9px;
            letter-spacing: 3px;
            text-transform: uppercase;
            color: var(--gold);
            background: var(--gold-pale);
            backdrop-filter: blur(4px);
            margin-bottom: 28px;
        }

        .portal-badge::before {
            content: '';
            width: 6px; height: 6px;
            background: var(--gold);
            border-radius: 50%;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.5; transform: scale(1.6); }
        }

        .portal-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: clamp(32px, 4.5vw, 52px);
            font-weight: 300;
            line-height: 1.15;
            letter-spacing: 1px;
            margin-bottom: 14px;
        }

        .portal-title em {
            font-style: italic;
            color: var(--gold-light);
        }

        .portal-subtitle {
            font-size: 12px;
            line-height: 1.8;
            color: var(--text-muted);
            max-width: 420px;
            margin: 0 auto;
            font-weight: 300;
        }

        /* ── ROLE CARDS ── */
        .role-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            width: 100%;
            max-width: 720px;
            margin-bottom: 48px;
        }

        .role-card {
            position: relative;
            background: rgba(193, 193, 193, 0.42);
            border: 1px solid rgba(255,255,255,0.06);
            border-radius: 16px;
            padding: 44px 32px 40px;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            gap: 18px;
            text-decoration: none;
            overflow: hidden;
        }

        /* card shine effect */
        .role-card::before {
            content: '';
            position: absolute;
            top: 0; left: -100%;
            width: 100%; height: 100%;
            background: linear-gradient(
                90deg,
                transparent,
                rgba(255,255,255,0.03),
                transparent
            );
            transition: left 0.6s ease;
        }

        .role-card:hover::before {
            left: 100%;
        }

        /* card glow ring */
        .role-card::after {
            content: '';
            position: absolute;
            inset: -1px;
            border-radius: 16px;
            padding: 1px;
            background: linear-gradient(135deg, transparent 10%, var(--gold) 100%);
            webkit-mask: linear-gradient(#fff, #fff) content-box, linear-gradient(#fff, #fff);
            mask: linear-gradient(#fff, #fff) content-box, linear-gradient(#fff, #fff);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            opacity: 0;
            transition: opacity 0.4s ease;
        }

        .role-card:hover::after { opacity: 1; }

        .role-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 24px 64px rgba(0,0,0,0.5);
        }

        /* Staff card hover */
        .role-card--staff:hover {
            background: var(--accent-staff-glow);
            border-color: rgba(92,142,201,0.3);
        }
        .role-card--staff:hover::after {
            background: linear-gradient(135deg, transparent 40%, var(--accent-staff) 100%);
        }

        /* Manager card hover */
        .role-card--mgr:hover {
            background: var(--accent-mgr-glow);
            border-color: rgba(201,122,92,0.3);
        }
        .role-card--mgr:hover::after {
            background: linear-gradient(135deg, transparent 40%, var(--accent-mgr) 100%);
        }

        .role-icon-wrap {
            width: 72px; height: 72px;
            border-radius: 50%;
            display: grid; place-items: center;
            font-size: 32px;
            transition: all 0.4s ease;
        }

        .role-card--staff .role-icon-wrap {
            background: var(--accent-staff-glow);
            border: 1px solid rgba(92,142,201,0.2);
        }

        .role-card--mgr .role-icon-wrap {
            background: var(--accent-mgr-glow);
            border: 1px solid rgba(201,122,92,0.2);
        }

        .role-card:hover .role-icon-wrap {
            transform: scale(1.1);
        }

        .role-label {
            font-family: 'Montserrat', sans-serif;
            font-size: 11px;
            letter-spacing: 3.5px;
            text-transform: uppercase;
            color: #fff;
            font-weight: 600;
            transition: color 0.3s;
        }

        .role-card--staff:hover .role-label { color: var(--accent-staff); }
        .role-card--mgr:hover .role-label   { color: var(--accent-mgr); }

        .role-desc {
            font-size: 12px;
            color: var(--text-muted);
            line-height: 1.75;
            font-weight: 300;
            max-width: 240px;
        }

        .role-arrow {
            margin-top: 6px;
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: var(--text-faint);
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .role-arrow span {
            display: inline-block;
            transition: transform 0.3s;
        }

        .role-card:hover .role-arrow {
            color: var(--gold);
        }

        .role-card:hover .role-arrow span {
            transform: translateX(6px);
        }

        /* ── FOOTER ── */
        .portal-footer {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 28px;
            flex-wrap: wrap;
        }

        .footer-item {
            font-size: 10px;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: var(--text-faint);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .footer-dot {
            width: 3px; height: 3px;
            background: var(--text-faint);
            border-radius: 50%;
        }

        .footer-divider {
            width: 1px; height: 14px;
            background: rgba(255,255,255,0.08);
        }

        /* ── TIME DISPLAY ── */
        .time-display {
            position: fixed;
            top: 40px; right: 48px;
            text-align: right;
            z-index: 10;
        }

        .time-clock {
            font-family: 'Cormorant Garamond', serif;
            font-size: 28px;
            font-weight: 300;
            color: var(--text);
            letter-spacing: 2px;
        }

        .time-date {
            font-size: 9px;
            letter-spacing: 2.5px;
            text-transform: uppercase;
            color: var(--text-faint);
            margin-top: 4px;
        }

        /* ── RESTRICTED NOTICE ── */
        .restricted-notice {
            position: fixed;
            top: 44px; left: 48px;
            display: flex;
            align-items: center;
            gap: 10px;
            z-index: 10;
        }

        .restricted-icon {
            width: 32px; height: 32px;
            border: 1px solid rgba(201,165,92,0.25);
            border-radius: 8px;
            display: grid; place-items: center;
            font-size: 14px;
            background: rgba(201,165,92,0.05);
        }

        .restricted-text {
            font-size: 9px;
            letter-spacing: 2.5px;
            text-transform: uppercase;
            color: var(--text-faint);
            line-height: 1.6;
        }

        .restricted-text strong {
            color: var(--gold);
            font-weight: 500;
            display: block;
        }

        /* ── ENTRANCE ANIMATIONS ── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(28px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to   { opacity: 1; }
        }

        .logo             { animation: fadeUp 0.7s ease both; animation-delay: 0.1s; }
        .portal-badge     { animation: fadeUp 0.7s ease both; animation-delay: 0.2s; }
        .portal-title     { animation: fadeUp 0.7s ease both; animation-delay: 0.3s; }
        .portal-subtitle  { animation: fadeUp 0.7s ease both; animation-delay: 0.4s; }
        .role-card--staff { animation: fadeUp 0.7s ease both; animation-delay: 0.55s; }
        .role-card--mgr   { animation: fadeUp 0.7s ease both; animation-delay: 0.65s; }
        .portal-footer    { animation: fadeUp 0.7s ease both; animation-delay: 0.8s; }
        .restricted-notice{ animation: fadeIn 0.8s ease both; animation-delay: 0.6s; }
        .time-display     { animation: fadeIn 0.8s ease both; animation-delay: 0.6s; }

        /* ── RESPONSIVE ── */
        @media (max-width: 640px) {
            html, body { overflow: auto; }
            .role-grid {
                grid-template-columns: 1fr;
                max-width: 380px;
            }
            .restricted-notice,
            .time-display { display: none; }
            .portal { padding: 60px 20px 40px; }
            .role-card { padding: 36px 24px 32px; }
        }

        @media (max-width: 400px) {
            .portal-title { font-size: 28px; }
        }
    </style>
</head>
<body>

<!-- ═══════════ BACKGROUND ═══════════ -->
<div class="bg-layer">
    <div class="bg-image"></div>
    <div class="bg-overlay"></div>
    <div class="bg-grain"></div>
    <div class="bg-orb bg-orb--gold"></div>
    <div class="bg-orb bg-orb--blue"></div>
</div>

<!-- ═══════════ RESTRICTED NOTICE ═══════════ -->
<div class="restricted-notice" id="restrictedNotice">
    <div class="restricted-icon">🔒</div>
    <div class="restricted-text">
        <strong>Authorized Access Only</strong>
        Internal Staff Portal
    </div>
</div>

<!-- ═══════════ TIME DISPLAY ═══════════ -->
<div class="time-display" id="timeDisplay">
    <div class="time-clock" id="timeClock">--:--</div>
    <div class="time-date" id="timeDate">Loading...</div>
</div>

<!-- ═══════════ MAIN PORTAL ═══════════ -->
<div class="portal">

    <!-- Logo -->
    <div class="logo">
        <div class="logo-mark">⚓</div>
        <div class="logo-text">Ocean<span>.View</span></div>
    </div>

    <!-- Header -->
    <div class="portal-header">
        <div class="portal-badge">Staff & Management Portal</div>
        <h1 class="portal-title">
            Welcome to the<br>
            <em>Operations Hub</em>
        </h1>
        <p class="portal-subtitle">
            Access the resort management system. Select your role below
            to proceed to the secure sign-in portal.
        </p>
    </div>

    <!-- Role Selection Cards -->
    <div class="role-grid">

        <div class="role-card role-card--staff" id="staffCard" onclick="selectRole('STAFF')">
            <div class="role-icon-wrap">🛎️</div>
            <div class="role-label">Staff</div>
            <div class="role-desc">
                Handle check-ins, manage reservations, and assist day-to-day operations.
            </div>
            <div class="role-arrow">Sign In <span>→</span></div>
        </div>

        <div class="role-card role-card--mgr" id="managerCard" onclick="selectRole('MANAGER')">
            <div class="role-icon-wrap">💼</div>
            <div class="role-label">Manager</div>
            <div class="role-desc">
                Full administrative access, financial reports, and complete system oversight.
            </div>
            <div class="role-arrow">Sign In <span>→</span></div>
        </div>

    </div>

    <!-- Footer -->
    <div class="portal-footer">
        <div class="footer-item">
            <div class="footer-dot"></div>
            Ocean View Resort & Spa
        </div>
        <div class="footer-divider"></div>
        <div class="footer-item">Galle, Sri Lanka</div>
        <div class="footer-divider"></div>
        <div class="footer-item">&copy; 2025 All Rights Reserved</div>
    </div>

</div>

<script>
    // ── Navigate to Login ──
    function selectRole(role) {
        window.location.href = 'Auth/Login.jsp?role=' + role;
    }

    // ── Live Clock ──
    function updateTime() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const mins  = String(now.getMinutes()).padStart(2, '0');
        document.getElementById('timeClock').textContent = hours + ':' + mins;

        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        document.getElementById('timeDate').textContent = now.toLocaleDateString('en-US', options);
    }

    updateTime();
    setInterval(updateTime, 10000);

    // ── Keyboard shortcuts ──
    document.addEventListener('keydown', function(e) {
        if (e.key === '1' || e.key === 's' || e.key === 'S') {
            selectRole('STAFF');
        } else if (e.key === '2' || e.key === 'm' || e.key === 'M') {
            selectRole('MANAGER');
        }
    });
</script>

</body>
</html>
