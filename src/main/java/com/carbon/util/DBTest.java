package com.carbon.util;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        try (Connection connection = DBConnection.getConnection()) {

            System.out.println("=================================");
            System.out.println("DATABASE CONNECTION SUCCESSFUL");
            System.out.println("=================================");
            System.out.println("Database: carbon_footprint_db");
            System.out.println("URL: jdbc:mariadb://localhost:3306/carbon_footprint_db");
            System.out.println("Connected: " + !connection.isClosed());

        } catch (Exception e) {

            System.out.println("=================================");
            System.out.println("DATABASE CONNECTION FAILED");
            System.out.println("=================================");

            e.printStackTrace();
        }
    }
}