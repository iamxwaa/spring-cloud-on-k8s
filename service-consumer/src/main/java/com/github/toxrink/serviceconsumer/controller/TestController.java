package com.github.toxrink.serviceconsumer.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Controller
public class TestController {

    @Autowired
    private RestTemplate restTemplate;

    @GetMapping("/test")
    @ResponseBody
    public Map<String, Object> test() {
        Map<String, Object> map = restTemplate.getForObject("http://service-producer/test", Map.class);
        map.put("from2", "service-producer");
        return map;
    }
}
