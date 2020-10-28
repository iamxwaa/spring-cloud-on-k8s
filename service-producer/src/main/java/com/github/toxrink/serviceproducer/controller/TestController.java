package com.github.toxrink.serviceproducer.controller;

import java.util.HashMap;
import java.util.Map;

import com.github.toxrink.serviceproducer.config.MysqlConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
        return map;
    }
}
