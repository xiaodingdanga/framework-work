package com.lx.framework;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;


/**
 * @author xin.liu
 * @description TODO
 * @date 2024-02-28  14:40
 * @Version 1.0
 */
@EnableAsync
@SpringBootApplication
public class FrameWorkApplication{

    public static void main(String[] args) {
        SpringApplication.run(FrameWorkApplication.class,args);
    }

}