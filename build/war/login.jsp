<!DOCTYPE html>
<html>
<head>
    <title>Login | Carbon Footprint Calculator</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<div class="container">

    <h1>🛡️ Carbon Footprint Calculator</h1>

    <h2>Login</h2>

    <% if (request.getAttribute("error") != null) { %>

        <div class="error">
            <%= request.getAttribute("error") %>
        </div>

    <% } %>

    <form method="post"
          action="${pageContext.request.contextPath}/login">

        <label>Email</label>

        <input type="email"
               name="email"
               required>

        <label>Password</label>

        <input type="password"
               name="password"
               required>

        <button type="submit">
            Login
        </button>

    </form>

    <p>
        Test account:
        <strong>testuser@example.com</strong>
        /
        <strong>test123</strong>
    </p>

</div>

</body>
</html>