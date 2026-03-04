<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ocean View Resort — Staff & Management Portal</title>
        <meta name="description"
            content="Internal staff and management portal for Ocean View Resort, Galle, Sri Lanka.">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link
            href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400;1,600&family=Inter:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <style>
            *,
            *::before,
            *::after {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            :root {
                --gold: #c9a55c;
                --gold-dark: #a8833a;
                --gold-light: #e8c98a;
                --staff: #3b82f6;
                --staff-light: #eff6ff;
                --staff-border: #bfdbfe;
                --mgr: #dc6b3a;
                --mgr-light: #fff7ed;
                --mgr-border: #fed7aa;
                --text: #111827;
                --text-2: #020e13;
                --text-3: #000000;
                --text-4: #020e13;
                --border: #e5e7eb;
                --bg: #ffffff;
            }

            html,
            body {
                height: 100%;
                overflow: hidden;
                font-family: 'Inter', sans-serif;
            }

            /* ══════ SPLIT LAYOUT ══════ */
            .split {
                display: flex;
                height: 100vh;
                width: 100vw;
            }

            /* ══════ LEFT — PURE IMAGE ══════ */
            .split-left {
                width: 50%;
                position: relative;
                overflow: hidden;
                flex-shrink: 0;
            }

            .split-left img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
                animation: slowZoom 20s ease-in-out infinite alternate;
            }

            @keyframes slowZoom {
                from {
                    transform: scale(1.0);
                }

                to {
                    transform: scale(1.08);
                }
            }

            /* Thin gold line on right edge */
            .split-left::after {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                width: 4px;
                height: 100%;
                background: linear-gradient(180deg, transparent 0%, var(--gold) 30%, var(--gold) 70%, transparent 100%);
                z-index: 2;
            }

            /* ══════ RIGHT — WHITE PANEL ══════ */
            .split-right {
                width: 50%;
                background: var(--bg);
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            /* Gold top accent line */
            .top-line {
                height: 4px;
                background: linear-gradient(90deg, var(--gold), var(--gold-light), var(--gold));
                flex-shrink: 0;
            }

            /* Main scrollable area */
            .portal-body {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
                padding: 40px 56px;
                overflow-y: auto;
            }

            /* ── Logo ── */
            .logo-row {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 48px;
                animation: fadeUp 0.5s ease both;
            }

            .logo-icon {
                width: 44px;
                height: 44px;
                border-radius: 10px;
                background: #111827;
                display: grid;
                place-items: center;
                font-size: 18px;
                flex-shrink: 0;
            }

            .logo-text-wrap {
                display: flex;
                flex-direction: column;
            }

            .logo-name {
                font-family: 'Playfair Display', serif;
                font-size: 16px;
                font-weight: 700;
                letter-spacing: 1px;
                color: var(--text);
                line-height: 1;
            }

            .logo-name span {
                color: var(--gold-dark);
            }

            .logo-sub {
                font-size: 9px;
                letter-spacing: 2.5px;
                text-transform: uppercase;
                color: var(--text-4);
                margin-top: 3px;
            }

            /* ── Heading ── */
            .portal-eyebrow {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                font-size: 10px;
                letter-spacing: 3px;
                text-transform: uppercase;
                color: var(--gold-dark);
                font-weight: 600;
                margin-bottom: 12px;
                animation: fadeUp 0.5s ease 0.05s both;
            }

            .portal-eyebrow::before {
                content: '';
                width: 18px;
                height: 2px;
                background: var(--gold);
                border-radius: 1px;
            }

            .portal-heading {
                font-family: 'Playfair Display', serif;
                font-size: clamp(26px, 3vw, 38px);
                font-weight: 700;
                color: var(--text);
                line-height: 1.2;
                letter-spacing: -0.5px;
                margin-bottom: 10px;
                animation: fadeUp 0.5s ease 0.1s both;
            }

            .portal-heading em {
                font-style: italic;
                color: var(--gold-dark);
                font-weight: 600;
            }

            .portal-sub {
                font-size: 13px;
                color: var(--text-3);
                line-height: 1.75;
                font-weight: 400;
                max-width: 360px;
                margin-bottom: 36px;
                animation: fadeUp 0.5s ease 0.15s both;
            }

            /* ── Divider ── */
            .divider {
                display: flex;
                align-items: center;
                gap: 14px;
                margin-bottom: 24px;
                animation: fadeUp 0.5s ease 0.2s both;
            }

            .divider-line {
                flex: 1;
                height: 1px;
                background: var(--border);
            }

            .divider-label {
                font-size: 10px;
                letter-spacing: 2px;
                text-transform: uppercase;
                color: var(--text-4);
                white-space: nowrap;
            }

            /* ── Role Cards ── */
            .cards {
                display: flex;
                flex-direction: column;
                gap: 14px;
                animation: fadeUp 0.5s ease 0.25s both;
            }

            .role-card {
                display: flex;
                align-items: center;
                gap: 16px;
                padding: 20px 22px;
                border-radius: 14px;
                border: 1.5px solid var(--border);
                background: #f9fafb;
                cursor: pointer;
                text-decoration: none;
                color: inherit;
                transition: all 0.28s cubic-bezier(0.23, 1, 0.32, 1);
                position: relative;
                overflow: hidden;
            }

            /* Hover fill */
            .role-card::before {
                content: '';
                position: absolute;
                inset: 0;
                opacity: 0;
                transition: opacity 0.28s ease;
            }

            .role-card--staff::before {
                background: var(--staff-light);
            }

            .role-card--mgr::before {
                background: var(--mgr-light);
            }

            .role-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.1);
            }

            .role-card--staff:hover {
                border-color: var(--staff-border);
            }

            .role-card--mgr:hover {
                border-color: var(--mgr-border);
            }

            .role-card:hover::before {
                opacity: 1;
            }

            /* Icon */
            .card-icon {
                width: 50px;
                height: 50px;
                border-radius: 12px;
                display: grid;
                place-items: center;
                font-size: 22px;
                flex-shrink: 0;
                position: relative;
                z-index: 1;
                transition: transform 0.28s ease;
            }

            .role-card--staff .card-icon {
                background: var(--staff-light);
                border: 1.5px solid var(--staff-border);
            }

            .role-card--mgr .card-icon {
                background: var(--mgr-light);
                border: 1.5px solid var(--mgr-border);
            }

            .role-card:hover .card-icon {
                transform: scale(1.08);
            }

            /* Text */
            .card-body {
                flex: 1;
                position: relative;
                z-index: 1;
            }

            .card-title {
                font-size: 14px;
                font-weight: 600;
                color: var(--text);
                margin-bottom: 3px;
                letter-spacing: 0.2px;
            }

            .role-card--staff:hover .card-title {
                color: var(--staff);
            }

            .role-card--mgr:hover .card-title {
                color: var(--mgr);
            }

            .card-desc {
                font-size: 12px;
                color: var(--text-3);
                line-height: 1.55;
                font-weight: 400;
            }

            /* Arrow */
            .card-arrow {
                width: 32px;
                height: 32px;
                border-radius: 8px;
                border: 1.5px solid var(--border);
                background: #fff;
                display: grid;
                place-items: center;
                color: var(--text-4);
                font-size: 13px;
                flex-shrink: 0;
                position: relative;
                z-index: 1;
                transition: all 0.28s ease;
            }

            .role-card--staff:hover .card-arrow {
                background: var(--staff);
                border-color: var(--staff);
                color: #fff;
                transform: translateX(3px);
            }

            .role-card--mgr:hover .card-arrow {
                background: var(--mgr);
                border-color: var(--mgr);
                color: #fff;
                transform: translateX(3px);
            }

            /* Keyboard hint */
            .kb-hint {
                font-size: 10px;
                letter-spacing: 1px;
                color: var(--text-4);
                margin-top: 16px;
                text-align: center;
                animation: fadeUp 0.5s ease 0.35s both;
            }

            .kb-hint kbd {
                display: inline-block;
                padding: 2px 7px;
                border-radius: 5px;
                border: 1.5px solid var(--border);
                background: #f3f4f6;
                font-family: inherit;
                font-size: 10px;
                color: var(--text-2);
                font-weight: 600;
            }

            /* ── Footer ── */
            .portal-footer {
                padding: 18px 56px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-top: 1px solid var(--border);
                flex-shrink: 0;
                animation: fadeUp 0.5s ease 0.4s both;
            }

            .footer-copy {
                font-size: 10px;
                letter-spacing: 1px;
                text-transform: uppercase;
                color: var(--text-4);
            }

            .footer-clock {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 11px;
                color: var(--text-3);
                font-weight: 500;
            }

            .footer-clock::before {
                content: '';
                width: 6px;
                height: 6px;
                border-radius: 50%;
                background: #22c55e;
                animation: pulse 2s ease-in-out infinite;
            }

            @keyframes pulse {

                0%,
                100% {
                    opacity: 1;
                    transform: scale(1);
                }

                50% {
                    opacity: 0.5;
                    transform: scale(1.5);
                }
            }

            /* Animations */
            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(18px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* ── RESPONSIVE ── */
            @media (max-width: 820px) {

                html,
                body {
                    overflow: auto;
                }

                .split {
                    flex-direction: column;
                    height: auto;
                }

                .split-left {
                    width: 100%;
                    height: 45vh;
                }

                .split-right {
                    width: 100%;
                }

                .portal-body {
                    padding: 36px 32px;
                }

                .portal-footer {
                    padding: 16px 32px;
                }
            }

            @media (max-width: 480px) {
                .portal-body {
                    padding: 28px 20px;
                }

                .portal-footer {
                    padding: 14px 20px;
                    flex-direction: column;
                    gap: 8px;
                }
            }
        </style>
    </head>

    <body>

        <div class="split">

            <!-- ════════ LEFT — IMAGE ONLY ════════ -->
            <div class="split-left">
                <img src="assets/hero.jpg" alt="Ocean View Resort" draggable="false">
            </div>

            <!-- ════════ RIGHT — WHITE PORTAL ════════ -->
            <div class="split-right">

                <div class="top-line"></div>

                <div class="portal-body">

                    <!-- Logo -->
                    <div class="logo-row">
                        <div class="logo-icon">⚓</div>
                        <div class="logo-text-wrap">
                            <div class="logo-name">Ocean<span>.View</span></div>
                            <div class="logo-sub">Resort &amp; Spa · Internal Portal</div>
                        </div>
                    </div>

                    <!-- Heading -->
                    <div class="portal-eyebrow">Staff &amp; Manager Portal</div>

                    <h1 class="portal-heading">
                        Welcome to the<br>
                        <em>Operations Hub</em>
                    </h1>

                    <p class="portal-sub">
                        Select your role below to access the secure sign-in portal.
                        Authorized personnel only — all sessions are monitored.
                    </p>

                    <!-- Divider -->
                    <div class="divider">
                        <div class="divider-line"></div>
                        <span class="divider-label">Choose your access level</span>
                        <div class="divider-line"></div>
                    </div>

                    <!-- Cards -->
                    <div class="cards">

                        <a class="role-card role-card--staff" href="Auth/Login.jsp?role=STAFF" id="staffCard"
                            onclick="animateClick(this); return false;">
                            <div class="card-icon">🛎️</div>
                            <div class="card-body">
                                <div class="card-title">Staff Access</div>
                                <div class="card-desc">Manage check-ins, reservations &amp; daily resort operations.
                                </div>
                            </div>
                            <div class="card-arrow">→</div>
                        </a>

                        <a class="role-card role-card--mgr" href="Auth/Login.jsp?role=MANAGER" id="managerCard"
                            onclick="animateClick(this); return false;">
                            <div class="card-icon">💼</div>
                            <div class="card-body">
                                <div class="card-title">Manager Access</div>
                                <div class="card-desc">Full admin control — staff, reports, rooms &amp; system
                                    oversight.</div>
                            </div>
                            <div class="card-arrow">→</div>
                        </a>

                    </div>

                    <p class="kb-hint">
                        Press <kbd>S</kbd> for Staff &nbsp;·&nbsp; <kbd>M</kbd> for Manager
                    </p>

                </div>

                <!-- Footer -->
                <div class="portal-footer">
                    <span class="footer-copy">© 2025 Ocean View Resort &amp; Spa · Galle, Sri Lanka</span>
                    <div class="footer-clock" id="footerClock">--:--</div>
                </div>

            </div>
        </div>

        <script>
            // ── Navigate with click animation ──
            function animateClick(el) {
                el.style.transform = 'scale(0.97)';
                el.style.transition = 'transform 0.15s ease';
                setTimeout(() => {
                    window.location.href = el.getAttribute('href');
                }, 150);
            }

            // ── Live Clock ──
            function updateClock() {
                const now = new Date();
                const hh = String(now.getHours()).padStart(2, '0');
                const mm = String(now.getMinutes()).padStart(2, '0');
                document.getElementById('footerClock').textContent = hh + ':' + mm;
            }
            updateClock();
            setInterval(updateClock, 10000);

            // ── Keyboard Shortcuts ──
            document.addEventListener('keydown', function (e) {
                if (e.key === 's' || e.key === 'S') {
                    animateClick(document.getElementById('staffCard'));
                } else if (e.key === 'm' || e.key === 'M') {
                    animateClick(document.getElementById('managerCard'));
                }
            });
        </script>

    </body>

    </html>