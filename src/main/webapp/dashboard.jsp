<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.carbon.model.CarbonRecord" %>

<!DOCTYPE html>
<html>

<head>

    <title>Dashboard | Carbon Footprint Calculator</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<div class="container">

    <div class="header">

        <div>

            <h1>🌱 Carbon Footprint Dashboard - CI/CD</h1>

            <p>
                Welcome,
                <strong>
                    <%= session.getAttribute("userName") %>
                </strong>
            </p>

        </div>

        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>

    </div>

    <div class="card">

        <h2>Total Carbon Emission</h2>

        <div class="total">

            <%= request.getAttribute("totalEmission") %>

            kg CO₂

        </div>

    </div>


    <div class="card">

        <h2>Add Activity</h2>

        <form method="post"
              action="${pageContext.request.contextPath}/carbon">

            <input type="hidden"
                   name="action"
                   value="add">

            <label>Activity</label>

            <select name="activityType" required>

                <option value="Car Travel">
                    Car Travel
                </option>

                <option value="Bus Travel">
                    Bus Travel
                </option>

                <option value="Train Travel">
                    Train Travel
                </option>

                <option value="Electricity">
                    Electricity
                </option>

                <option value="LPG">
                    LPG
                </option>

                <option value="Waste">
                    Waste
                </option>

            </select>

            <label>Value</label>

            <input type="number"
                   name="activityValue"
                   step="0.01"
                   min="0"
                   required>

            <label>Unit</label>

            <select name="unit" required>

                <option value="km">km</option>
                <option value="kWh">kWh</option>
                <option value="kg">kg</option>

            </select>

            <button type="submit">
                Add Record
            </button>

        </form>

    </div>


    <div class="card">

        <h2>My Carbon Records</h2>

        <table>

            <tr>

                <th>Date</th>
                <th>Activity</th>
                <th>Value</th>
                <th>Unit</th>
                <th>Factor</th>
                <th>Emission</th>
                <th>Action</th>

            </tr>

            <%

                List<CarbonRecord> records =
                    (List<CarbonRecord>)
                    request.getAttribute("records");

                for (CarbonRecord record : records) {

            %>

            <tr>

                <td>
                    <%= record.getRecordDate() %>
                </td>

                <td>
                    <%= record.getActivityType() %>
                </td>

                <td>
                    <%= record.getActivityValue() %>
                </td>

                <td>
                    <%= record.getUnit() %>
                </td>

                <td>
                    <%= record.getEmissionFactor() %>
                </td>

                <td>
                    <%= record.getCarbonEmission() %>
                    kg CO₂
                </td>

                <td>

                    <form method="post"
                          action="${pageContext.request.contextPath}/carbon">

                        <input type="hidden"
                               name="action"
                               value="delete">

                        <input type="hidden"
                               name="recordId"
                               value="<%= record.getRecordId() %>">

                        <button type="submit">
                            Delete
                        </button>

                    </form>

                </td>

            </tr>

            <% } %>

        </table>

    </div>

</div>

</body>

</html>