<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.carbon.model.CarbonRecord" %>
<%!
    /* Escape text before writing it into HTML. */
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

    /* Activity -> colour key used by css/dashboard.css (c-*, s-*). */
    private static String key(String activity) {
        if (activity == null) return "other";
        switch (activity) {
            case "Car Travel":   return "car";
            case "Bus Travel":   return "bus";
            case "Train Travel": return "train";
            case "Electricity":  return "electricity";
            case "LPG":          return "lpg";
            case "Waste":        return "waste";
            default:             return "other";
        }
    }

    private static String num(double value, int decimals) {
        return String.format(Locale.US, "%." + decimals + "f", value);
    }

    private static double val(BigDecimal b) {
        return b == null ? 0 : b.doubleValue();
    }
%>
<%
    /* ---------- Data prepared by DashboardServlet ---------- */
    @SuppressWarnings("unchecked")
    List<CarbonRecord> records = (List<CarbonRecord>) request.getAttribute("records");
    if (records == null) records = Collections.emptyList();

    Object totalAttr = request.getAttribute("totalEmission");
    BigDecimal total = (totalAttr instanceof BigDecimal) ? (BigDecimal) totalAttr : BigDecimal.ZERO;
    String totalText = (totalAttr != null) ? totalAttr.toString() : "0.0000";

    /* Totals per activity (largest first) and per day per activity */
    Map<String, Double> byActivity = new LinkedHashMap<>();
    TreeMap<LocalDate, Map<String, Double>> byDate = new TreeMap<>();
    double summed = 0;
    for (CarbonRecord r : records) {
        double e = val(r.getCarbonEmission());
        byActivity.merge(r.getActivityType(), e, Double::sum);
        if (r.getRecordDate() != null) {
            byDate.computeIfAbsent(r.getRecordDate(), d -> new LinkedHashMap<>())
                  .merge(r.getActivityType(), e, Double::sum);
        }
        summed += e;
    }
    List<Map.Entry<String, Double>> breakdown = new ArrayList<>(byActivity.entrySet());
    breakdown.sort((a, b) -> Double.compare(b.getValue(), a.getValue()));

    double totalD = total.doubleValue() > 0 ? total.doubleValue() : summed;
    String topActivity = breakdown.isEmpty() ? "None yet" : breakdown.get(0).getKey();
    String topShare = (breakdown.isEmpty() || totalD <= 0) ? "0" : num(breakdown.get(0).getValue() / totalD * 100, 0);
    String average = records.isEmpty()
            ? "0.00"
            : total.divide(BigDecimal.valueOf(records.size()), 2, RoundingMode.HALF_UP).toPlainString();

    /* Last 14 days that have records, for the timeline */
    List<LocalDate> days = new ArrayList<>(byDate.keySet());
    if (days.size() > 14) days = days.subList(days.size() - 14, days.size());
    double maxDay = 0;
    for (LocalDate d : days) {
        double t = 0;
        for (double v : byDate.get(d).values()) t += v;
        maxDay = Math.max(maxDay, t);
    }
    DateTimeFormatter dayFmt = DateTimeFormatter.ofPattern("d MMM", Locale.ENGLISH);

    /* One-time message set by CarbonRecordServlet */
    Object flash = session.getAttribute("message");
    if (flash != null) session.removeAttribute("message");

    String ctx = request.getContextPath();
    String userName = String.valueOf(session.getAttribute("userName"));
    String initial = userName.isEmpty() ? "?" : userName.substring(0, 1).toUpperCase();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard | Carbon Footprint Calculator</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Sora:wght@500;600;700&family=Manrope:wght@400;500;600;700&display=swap">
    <link rel="stylesheet" href="<%= ctx %>/css/dashboard.css">
</head>
<body>

<div class="shell">

    <!-- ===================== App bar ===================== -->
    <header class="appbar">
        <a class="brand" href="<%= ctx %>/dashboard">
            <svg class="brand-mark" viewBox="0 0 32 32" aria-hidden="true">
                <path d="M7 25C7 14 14 7 26 6c0 12-7 19-17 19" fill="currentColor"/>
                <path d="M7 25c4-6 8-10 13-13" stroke="#10261D" stroke-width="1.8" fill="none" stroke-linecap="round"/>
            </svg>
            <span>Carbon Footprint</span>
        </a>

        <div class="user-card">
            <span class="avatar" aria-hidden="true"><%= esc(initial) %></span>
            <strong><%= esc(userName) %></strong>
            <a class="logout" href="<%= ctx %>/logout">Log out</a>
        </div>
    </header>

    <!-- ===================== Main ===================== -->
    <main class="main">

        <% if (flash != null) { %>
            <div class="flash" role="alert"><%= esc(flash) %></div>
        <% } %>

        <!-- Hero -->
        <section class="hero">
            <div class="hero-top">
                <div>
                    <h1>Carbon Footprint Dashboard</h1>
                    <p class="hero-sub">Welcome back, <%= esc(userName) %></p>
                </div>
                <span class="build"><i></i>Build 16, CI/CD v2</span>
            </div>

            <div class="hero-body">
                <div class="hero-total">
                    <p>Total carbon emission</p>
                    <div class="total"><%= esc(totalText) %></div>
                    <p class="unit">kilograms of CO₂</p>
                </div>

                <div class="hero-stats">
                    <div class="stat">
                        <p>Records</p>
                        <strong><%= records.size() %></strong>
                    </div>
                    <div class="stat">
                        <p>Average per record</p>
                        <strong><%= average %> <small>kg</small></strong>
                    </div>
                    <div class="stat">
                        <p>Largest source</p>
                        <strong><%= esc(topActivity) %></strong>
                        <% if (!breakdown.isEmpty()) { %><small><%= topShare %>% of total</small><% } %>
                    </div>
                </div>
            </div>
        </section>

        <!-- Form + timeline -->
        <div class="row row-a">

            <section class="card form-card">
                <h2>Add activity</h2>
                <form method="post" action="<%= ctx %>/carbon">
                    <input type="hidden" name="action" value="add">

                    <div class="field">
                        <label for="activityType">Activity</label>
                        <select id="activityType" name="activityType" required>
                            <option value="Car Travel">Car Travel</option>
                            <option value="Bus Travel">Bus Travel</option>
                            <option value="Train Travel">Train Travel</option>
                            <option value="Electricity">Electricity</option>
                            <option value="LPG">LPG</option>
                            <option value="Waste">Waste</option>
                        </select>
                    </div>

                    <div class="field-row">
                        <div class="field">
                            <label for="activityValue">Amount</label>
                            <input id="activityValue" type="number" name="activityValue"
                                   step="0.01" min="0" required>
                        </div>
                        <div class="field">
                            <label for="unit">Unit</label>
                            <select id="unit" name="unit" required>
                                <option value="km">km</option>
                                <option value="kWh">kWh</option>
                                <option value="kg">kg</option>
                            </select>
                        </div>
                    </div>

                    <button class="btn-primary" type="submit">Add record</button>
                </form>
            </section>

            <section class="card">
                <div class="card-head">
                    <h2>Emissions over time</h2>
                    <span class="muted">kg CO₂ per day</span>
                </div>
                <% if (days.isEmpty() || maxDay <= 0) { %>
                    <div class="empty">No records yet.</div>
                <% } else { %>
                    <div class="timeline" role="img" aria-label="Daily emissions, stacked by activity">
                        <% for (LocalDate d : days) {
                               Map<String, Double> parts = byDate.get(d);
                               double dayTotal = 0;
                               for (double v : parts.values()) dayTotal += v; %>
                            <div class="day" title="<%= d %>: <%= num(dayTotal, 2) %> kg">
                                <div class="day-plot">
                                    <div class="day-col" style="height: <%= num(dayTotal / maxDay * 100, 1) %>%">
                                        <span class="day-value"><%= num(dayTotal, 1) %></span>
                                        <div class="day-bar">
                                            <% for (Map.Entry<String, Double> p : parts.entrySet()) { %>
                                                <i class="c-<%= key(p.getKey()) %>"
                                                   style="flex-grow: <%= num(p.getValue(), 4) %>"></i>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                                <span class="day-label"><%= d.format(dayFmt) %></span>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </section>
        </div>

        <!-- Records -->
        <section class="card table-card">
                <div class="card-head">
                    <h2>My carbon records</h2>
                    <span class="muted"><%= records.size() %> <%= records.size() == 1 ? "entry" : "entries" %></span>
                </div>

                <% if (records.isEmpty()) { %>
                    <div class="empty">No records yet.</div>
                <% } else { %>
                <div class="table-wrap">
                    <table class="records">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Activity</th>
                                <th class="num">Amount</th>
                                <th class="num">Factor</th>
                                <th class="num">Emission</th>
                                <th><span class="sr-only">Actions</span></th>
                            </tr>
                        </thead>
                        <tbody>
                        <% for (CarbonRecord record : records) { %>
                            <tr>
                                <td class="date"><%= esc(record.getRecordDate()) %></td>
                                <td>
                                    <span class="tag tag-<%= key(record.getActivityType()) %>">
                                        <%= esc(record.getActivityType()) %>
                                    </span>
                                </td>
                                <td class="num"><%= esc(record.getActivityValue()) %> <span class="muted"><%= esc(record.getUnit()) %></span></td>
                                <td class="num muted"><%= esc(record.getEmissionFactor()) %></td>
                                <td class="num emission"><%= esc(record.getCarbonEmission()) %> <span class="muted">kg</span></td>
                                <td class="num">
                                    <form method="post" action="<%= ctx %>/carbon"
                                          onsubmit="return confirm('Delete this record?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="recordId" value="<%= record.getRecordId() %>">
                                        <button class="btn-delete" type="submit" aria-label="Delete record">
                                            <svg viewBox="0 0 20 20" aria-hidden="true"><path d="M5 6h10M8 6V4h4v2M6.5 6l.7 10h5.6l.7-10" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>
            </section>

    </main>
</div>

<script>
    /* Pick the matching unit when the activity changes. */
    (function () {
        var activity = document.getElementById('activityType');
        var unit = document.getElementById('unit');
        var map = {
            'Car Travel': 'km', 'Bus Travel': 'km', 'Train Travel': 'km',
            'Electricity': 'kWh', 'LPG': 'kg', 'Waste': 'kg'
        };
        function sync() { if (map[activity.value]) unit.value = map[activity.value]; }
        activity.addEventListener('change', sync);
        sync();
    })();
</script>

</body>
</html>
