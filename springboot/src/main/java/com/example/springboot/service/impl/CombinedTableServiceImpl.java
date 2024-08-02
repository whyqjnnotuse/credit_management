package com.example.springboot.service.impl;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.example.springboot.entity.CombinedTable;
import com.example.springboot.mapper.CombinedTableMapper;
import com.example.springboot.service.ICombinedTableService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class CombinedTableServiceImpl extends ServiceImpl<CombinedTableMapper, CombinedTable> implements ICombinedTableService {
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
//            Class.forName("com.mysql.cj.jdbc.Driver");
            // 打开连接
            connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            // 合并 table1 和 table2 的数据并插入到 combined_table
//            String insertSQL = "INSERT INTO combined_table (user_code, username, credit_recipients, operation_type, loan_id, archive_location, contract_id, handover_time, Lending_institution, loan_amount, loan_date, last_date, file) " +
//                    "SELECT user_code, username, credit_recipients, operation_type,loan_id, archive_location, contract_id, handover_time, NULL AS Lending_institution, NULL AS loan_amount, NULL AS loan_date, NULL AS last_date, NULL AS file FROM management " +
//                    "UNION ALL " +
//                    "SELECT user_code,client_name AS username, NULL AS credit_recipients, business_variety AS operation_type, loan_voucher_id AS loan_id, NULL AS archive_location, loan_contract_id AS contract_id,  NULL AS handover_time, Lending_institution, loan_amount, loan_date, last_date, file FROM detail";

            // 创建 Statement 对象
            statement = connection.createStatement();
            // 插入 management 表的数据
            String insertManagementSQL = "INSERT INTO combined_table (user_code, username, credit_recipients, operation_type, loan_id, archive_location, contract_id, handover_time, Lending_institution, loan_amount, loan_date, last_date, file) " +
                    "SELECT user_code, username, credit_recipients, operation_type,loan_id, archive_location, contract_id, handover_time, NULL AS Lending_institution, NULL AS loan_amount, NULL AS loan_date, NULL AS last_date, NULL AS file FROM management " +
                    "ON DUPLICATE KEY UPDATE " +
                    "username = VALUES(username), credit_recipients = VALUES(credit_recipients), operation_type = VALUES(operation_type), loan_id = VALUES(loan_id), archive_location = VALUES(archive_location), contract_id = VALUES(contract_id), handover_time = VALUES(handover_time), " +
                    "Lending_institution = COALESCE(VALUES(Lending_institution), Lending_institution), loan_amount = COALESCE(VALUES(loan_amount), loan_amount), loan_date = COALESCE(VALUES(loan_date), loan_date), last_date = COALESCE(VALUES(last_date), last_date), file = COALESCE(VALUES(file), file)";
            statement.executeUpdate(insertManagementSQL);

            // 插入 detail 表的数据
            String insertDetailSQL = "INSERT INTO combined_table (user_code, username, credit_recipients, operation_type, loan_id, archive_location, contract_id, handover_time, Lending_institution, loan_amount, loan_date, last_date, file) " +
                    "SELECT user_code,client_name AS username, NULL AS credit_recipients, business_variety AS operation_type, loan_voucher_id AS loan_id, NULL AS archive_location, loan_contract_id AS contract_id,  NULL AS handover_time, Lending_institution, loan_amount, loan_date, last_date, file FROM detail " +
                    "ON DUPLICATE KEY UPDATE " +
                    "username = VALUES(username), credit_recipients = COALESCE(VALUES(credit_recipients), credit_recipients), operation_type = VALUES(operation_type), loan_id = VALUES(loan_id), archive_location = COALESCE(VALUES(archive_location), archive_location), contract_id = VALUES(contract_id), handover_time = COALESCE(VALUES(handover_time), handover_time), " +
                    "Lending_institution = VALUES(Lending_institution), loan_amount = VALUES(loan_amount), loan_date = VALUES(loan_date), last_date = VALUES(last_date), file = VALUES(file)";
            statement.executeUpdate(insertDetailSQL);


            System.out.println("数据合并成功!");

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
