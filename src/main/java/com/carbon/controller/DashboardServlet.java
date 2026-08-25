package com.carbon.controller;

import com.carbon.dao.CarbonRecordDAO;
import com.carbon.model.CarbonRecord;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final CarbonRecordDAO recordDAO = new CarbonRecordDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp"
            );

            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        List<CarbonRecord> records =
                recordDAO.getRecordsByUser(userId);

        BigDecimal total =
                recordDAO.getTotalEmission(userId);

        request.setAttribute("records", records);
        request.setAttribute("totalEmission", total);

        request.getRequestDispatcher("/dashboard.jsp")
               .forward(request, response);
    }
}