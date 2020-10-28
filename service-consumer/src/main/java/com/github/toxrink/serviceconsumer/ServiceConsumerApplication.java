package com.github.toxrink.serviceconsumer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@EnableDiscoveryClient
@SpringBootApplication
public class ServiceConsumerApplication {

    public static void main(String[] args) {
        SpringApplication.run(ServiceConsumerApplication.class, args);
    }

    @Configuration
    public class RestTemplateConfig {

        /**
         * 获取RestTemplate
         * 
         * @param restTemplateBuilder
         *                                RestTemplateBuilder
         * 
         * @return
         */
        @Bean
        @LoadBalanced
        public RestTemplate resultTemplate(RestTemplateBuilder restTemplateBuilder) {
            RestTemplate restTemplate = restTemplateBuilder.build();
            return restTemplate;
        }

    }
}
