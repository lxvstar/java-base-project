package com.sensetime.jv;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;


@ComponentScan("com.sensetime.jv")
//@MapperScan(basePackages = "com.sensetime.jv.dao")
@SpringBootApplication
@EnableConfigurationProperties
@EnableAsync
@EnableScheduling
public class StartApplication {
    public static void main(String[] args) {
        SpringApplication.run(StartApplication.class, args);
    }
}