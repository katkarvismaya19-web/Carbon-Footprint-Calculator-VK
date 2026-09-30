package com.carbon.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_HOST =
            System.getProperty(
                    "DB_HOST",
                    System.getenv().getOrDefault("DB_HOST", "localhost")
            );

    private static final String DB_PORT =
            System.getProperty(
                    "DB_PORT",
                    System.getenv().getOrDefault("DB_PORT", "3306")
            );

    private static final String DB_NAME =
            System.getProperty(
                    "DB_NAME",
                    System.getenv().getOrDefault("DB_NAME", "carbon_footprint_db")
            );

    private static final String URL =
            "jdbc:mariadb://" + DB_HOST + ":" + DB_PORT + "/" + DB_NAME;

    private static final String USER =
            System.getProperty(
                    "DB_USER",
                    System.getenv().getOrDefault("DB_USER", "root")
            );

    private static final String PASSWORD =
            System.getProperty(
                    "DB_PASSWORD",
                    System.getenv().getOrDefault("DB_PASSWORD", "")
            );

    static {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            System.out.println("MariaDB JDBC Driver loaded successfully.");
            System.out.println("Database URL: " + URL);
        } catch (ClassNotFoundException e) {
            System.err.println("MariaDB JDBC Driver NOT found.");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}