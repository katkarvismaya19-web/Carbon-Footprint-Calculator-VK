<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    private static String esc(Object value) {
        if (value == null) return "";
        String s = String.valueOf(value);
        StringBuilder out = new StringBuilder(s.length() + 16);
        for (char c : s.toCharArray()) {
            switch (c) {
                case '<':  out.append("&lt;");   break;
                case '>':  out.append("&gt;");   break;
                case '&':  out.append("&amp;");  break;
                case '"':  out.append("&quot;"); break;
                case '\'': out.append("&#39;");  break;
                default:   out.append(c);
            }
        }
        return out.toString();
    }
%>
<%
    String ctx = request.getContextPath();
    Object error = request.getAttribute("error");
    String email = request.getParameter("email");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login | Carbon Footprint Calculator</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Sora:wght@500;600;700&family=Manrope:wght@400;500;600;700&display=swap">
    <link rel="stylesheet" href="<%= ctx %>/css/dashboard.css">
</head>
<body class="login-page">

<div class="login">

    <!-- Left: brand panel -->
    <section class="login-art">
        <div class="brand">
            <svg class="brand-mark" viewBox="0 0 32 32" aria-hidden="true">
                <path d="M7 25C7 14 14 7 26 6c0 12-7 19-17 19" fill="currentColor"/>
                <path d="M7 25c4-6 8-10 13-13" stroke="#10261D" stroke-width="1.8" fill="none" stroke-linecap="round"/>
            </svg>
            <span>Carbon Footprint</span>
        </div>

        <div class="login-pitch">
            <h2>Know what your day costs the planet.</h2>
            <p>Log travel, electricity, LPG and waste. See your emissions add up, day by day.</p>
        </div>

        <ul class="login-activities" aria-label="Tracked activities">
            <li><i class="c-car"></i>Car</li>
            <li><i class="c-bus"></i>Bus</li>
            <li><i class="c-train"></i>Train</li>
            <li><i class="c-electricity"></i>Electricity</li>
            <li><i class="c-lpg"></i>LPG</li>
            <li><i class="c-waste"></i>Waste</li>
        </ul>
    </section>

    <!-- Right: form -->
    <main class="login-main">
        <div class="login-box">
            <h1>Sign in</h1>
            <p class="login-sub">Use your account to open your dashboard.</p>

            <% if (error != null) { %>
                <div class="flash" role="alert"><%= esc(error) %></div>
            <% } %>

            <form method="post" action="<%= ctx %>/login">
                <div class="field">
                    <label for="email">Email</label>
                    <input id="email" type="email" name="email"
                           value="<%= esc(email) %>" autocomplete="email" required autofocus>
                </div>

                <div class="field">
                    <label for="password">Password</label>
                    <div class="password">
                        <input id="password" type="password" name="password"
                               autocomplete="current-password" required>
                        <button type="button" class="reveal" aria-controls="password"
                                aria-pressed="false">Show</button>
                    </div>
                </div>

                <button class="btn-primary" type="submit">Sign in</button>
            </form>

            <div class="demo">
                <p>Demo account</p>
                <code>testuser@example.com</code>
                <code>test123</code>
            </div>
        </div>
    </main>
</div>

<script>
    (function () {
        var btn = document.querySelector('.reveal');
        var input = document.getElementById('password');
        btn.addEventListener('click', function () {
            var show = input.type === 'password';
            input.type = show ? 'text' : 'password';
            btn.textContent = show ? 'Hide' : 'Show';
            btn.setAttribute('aria-pressed', String(show));
        });
    })();
</script>

</body>
</html>
