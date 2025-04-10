package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GetConnection {

    public static Connection getConnection() {
        // Get database connection details from environment variables
        String jdbcUrl = System.getenv("JDBC_URL");
        String user = System.getenv("JDBC_USER");
        String password = System.getenv("JDBC_PASSWORD");
        
        // Use default values if environment variables are not set
        if (jdbcUrl == null) {
            jdbcUrl = "jdbc:mysql://host.docker.internal:3306/demo_erp";
        }
        if (user == null) {
            user = "root";
        }
        if (password == null) {
            password = "1234";
        }
        
        System.out.println("Connecting to DB with URL: " + jdbcUrl);
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found");
            e.printStackTrace();
            return null;
        }
;
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(jdbcUrl, user, password);
            System.out.println("Database connection established successfully");
        } catch (SQLException e) {
            System.err.println("Failed to connect to database");
            e.printStackTrace();
        }

        return connection;
    }
}