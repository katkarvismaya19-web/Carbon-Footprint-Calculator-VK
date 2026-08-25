package com.carbon.controller;

import com.carbon.dao.CarbonRecordDAO;
import com.carbon.model.CarbonRecord;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

@WebServlet("/carbon")
public class CarbonRecordServlet extends HttpServlet {

    private final CarbonRecordDAO recordDAO =
            new CarbonRecordDAO();

    @Override
    protected void doPost(
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

        int userId =
                (Integer) session.getAttribute("userId");

        String action = request.getParameter("action");

        try {

            if ("add".equals(action)) {

                String activityType =
                        request.getParameter("activityType");

                String unit =
                        request.getParameter("unit");

                BigDecimal activityValue =
                        new BigDecimal(
                                request.getParameter("activityValue")
                        );

                BigDecimal factor =
                        recordDAO.getEmissionFactor(
                                activityType,
                                unit
                        );

                if (factor == null) {
                    request.getSession().setAttribute(
                            "message",
                            "Invalid activity type or unit."
                    );

                    response.sendRedirect(
                            request.getContextPath() + "/dashboard"
                    );

                    return;
                }

                BigDecimal emission =
                        activityValue.multiply(factor);

                CarbonRecord record =
                        new CarbonRecord();

                record.setUserId(userId);
                record.setActivityType(activityType);
                record.setActivityValue(activityValue);
                record.setUnit(unit);
                record.setEmissionFactor(factor);
                record.setCarbonEmission(emission);
                record.setRecordDate(LocalDate.now());

                recordDAO.addRecord(record);

            } else if ("delete".equals(action)) {

                int recordId =
                        Integer.parseInt(
                                request.getParameter("recordId")
                        );

                recordDAO.deleteRecord(
                        recordId,
                        userId
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.getSession().setAttribute(
                    "message",
                    "Invalid input. Please try again."
            );
        }

        response.sendRedirect(
                request.getContextPath() + "/dashboard"
        );
    }
}