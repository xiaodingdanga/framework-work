package com.lx.framework.config;

import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SiteMeshConfig {

    @Bean
    public FilterRegistrationBean siteMeshFilter() {
        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setFilter(new ConfigurableSiteMeshFilter());
//        registration.addUrlPatterns("/*");
//        registration.setOrder(1);
        return registration;
    }
}