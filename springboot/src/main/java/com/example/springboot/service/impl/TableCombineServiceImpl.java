package com.example.springboot.service.impl;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TableCombineServiceImpl {
    @Value("${spring.datasource.url}")
    private String dbUrl;

    @Value("${spring.datasource.username}")
    private String dbUsername;

    @Value("${spring.datasource.password}")
    private String dbPassword;

    @PostConstruct
    public void combineTables() {
        Connection connection = null;
        Statement statement = null;

        try {
            // 注册 JDBC 驱动程序
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 打开连接
            connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // 创建表 combined_table
            String createTableSQL = "CREATE TABLE IF NOT EXISTS combined_table (id INT, name VARCHAR(255))";
            statement = connection.createStatement();
            statement.executeUpdate(createTableSQL);

            // 合并 table1 和 table2 的数据并插入到 combined_table
            String insertSQL = "INSERT INTO combined_table (id, name) " +
                    "SELECT id, name FROM   " +
                    "UNION ALL " +
                    "SELECT id, name FROM table2";
            statement.executeUpdate(insertSQL);

            System.out.println("Data combined successfully!");

        } catch (SQLException se) {
            se.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 关闭资源
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
