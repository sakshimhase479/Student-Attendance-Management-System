package com.sakshi.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = System.getenv("DB_URL");
            String username = System.getenv("DB_USER");
            String password = System.getenv("DB_PASSWORD");

            if (url == null || username == null || password == null) {
                throw new IllegalStateException(
                    "Database environment variables are missing"
                );
            }

            Connection con = DriverManager.getConnection(
                url, username, password
            );

            System.out.println("Connection successful");
            return con;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}