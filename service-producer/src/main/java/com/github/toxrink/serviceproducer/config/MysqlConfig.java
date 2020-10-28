package com.github.toxrink.serviceproducer.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.ToString;

@Component
@ConfigurationProperties("k8s")
@RefreshScope
@Data
@ToString
public class MysqlConfig {
    private String ip;

    private String port;

    private String user;

    private String authstring;

    private String from;
}
