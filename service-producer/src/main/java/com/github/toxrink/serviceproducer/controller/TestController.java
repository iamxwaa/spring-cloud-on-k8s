package com.github.toxrink.serviceproducer.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import com.github.toxrink.serviceproducer.config.MysqlConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class TestController {

    @Autowired
    private MysqlConfig mysqlConfig;

    @GetMapping("/test")
    @ResponseBody
    public Map<String, Object> test() {
        Map<String, Object> map = new HashMap<>();
        map.put("time", System.currentTimeMillis());
        map.put("mysqlConfig", mysqlConfig.toString());
        String url = "jdbc:mysql://" + mysqlConfig.getIp() + ":" + mysqlConfig.getPort() + "/k8s?useSSL=false";
        try {
            Connection conn = DriverManager.getConnection(url, mysqlConfig.getUser(), mysqlConfig.getAuthstring());
            Statement stmt = conn.createStatement();
            ResultSet resultSet = stmt.executeQuery("SELECT id, name, sex, age FROM user_info");

            Map<String, Object> map2 = new HashMap<>();
            while (resultSet.next()) {
                map2.put("id", resultSet.getLong(1));
                map2.put("name", resultSet.getString(2));
                map2.put("sex", resultSet.getString(3));
                map2.put("age", resultSet.getInt(4));
            }
            map.put("result", map2);
        } catch (SQLException e) {
            log.error(e);
            map.put("error", e.getMessage());
        }
        return map;
    }
}
