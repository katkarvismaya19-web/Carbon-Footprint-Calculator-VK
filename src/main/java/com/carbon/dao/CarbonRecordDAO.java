package com.carbon.dao;

import com.carbon.model.CarbonRecord;
import com.carbon.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CarbonRecordDAO {

    public BigDecimal getEmissionFactor(String activityType, String unit) {

        String sql = """
                SELECT emission_factor
                FROM emission_factors
                WHERE activity_type = ? AND unit = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, activityType);
            ps.setString(2, unit);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getBigDecimal("emission_factor");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean addRecord(CarbonRecord record) {

        String sql = """
                INSERT INTO carbon_records
                (user_id, activity_type, activity_value, unit,
                 emission_factor, carbon_emission, record_date)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, record.getUserId());
            ps.setString(2, record.getActivityType());
            ps.setBigDecimal(3, record.getActivityValue());
            ps.setString(4, record.getUnit());
            ps.setBigDecimal(5, record.getEmissionFactor());
            ps.setBigDecimal(6, record.getCarbonEmission());
            ps.setDate(7, Date.valueOf(record.getRecordDate()));

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<CarbonRecord> getRecordsByUser(int userId) {

        List<CarbonRecord> records = new ArrayList<>();

        String sql = """
                SELECT record_id, user_id, activity_type,
                       activity_value, unit, emission_factor,
                       carbon_emission, record_date
                FROM carbon_records
                WHERE user_id = ?
                ORDER BY record_date DESC, record_id DESC
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    CarbonRecord record = new CarbonRecord();

                    record.setRecordId(rs.getInt("record_id"));
                    record.setUserId(rs.getInt("user_id"));
                    record.setActivityType(rs.getString("activity_type"));
                    record.setActivityValue(rs.getBigDecimal("activity_value"));
                    record.setUnit(rs.getString("unit"));
                    record.setEmissionFactor(rs.getBigDecimal("emission_factor"));
                    record.setCarbonEmission(rs.getBigDecimal("carbon_emission"));

                    Date date = rs.getDate("record_date");

                    if (date != null) {
                        record.setRecordDate(date.toLocalDate());
                    }

                    records.add(record);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return records;
    }

    public boolean deleteRecord(int recordId, int userId) {

        String sql = """
                DELETE FROM carbon_records
                WHERE record_id = ? AND user_id = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, recordId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public BigDecimal getTotalEmission(int userId) {

        String sql = """
                SELECT COALESCE(SUM(carbon_emission), 0)
                FROM carbon_records
                WHERE user_id = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getBigDecimal(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return BigDecimal.ZERO;
    }
}