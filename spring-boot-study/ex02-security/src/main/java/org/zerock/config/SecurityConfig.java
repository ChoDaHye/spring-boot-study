package org.zerock.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.configuration.EnableGlobalAuthentication;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
//@EnableWebSecurity //웹보안 활성화를위한 annotation
//@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true) // 옛날 코드
@EnableMethodSecurity(securedEnabled = true)   // @Secured, @PreAuthorize, @PostAuthorize 어노테이션 사용해주는 어노테이션
public class SecurityConfig {

    @Bean
    BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        // method chaining으로 security 설정
        http
            .authorizeRequests((authorizeHttpRequests) ->
                    authorizeHttpRequests
                                    .requestMatchers(new AntPathRequestMatcher("/board/**")).authenticated() // /board로 시작하는 url은 인증을 받아야 함
                                    .requestMatchers(new AntPathRequestMatcher("/reply/**")).authenticated() // /reply로 시작하는 url은 인증을 받아야 함
//                                     .requestMatchers(new AntPathRequestMatcher("/join")).permitAll()
//                                     .requestMatchers(new AntPathRequestMatcher("/joinProc")).permitAll()
//                                     .requestMatchers(new AntPathRequestMatcher("/login")).permitAll()
                                    .requestMatchers(new AntPathRequestMatcher("/admin/**")).access("hasRole('ROLE_ADMIN')")   // role에 의한 접근 제어
                                    .requestMatchers(new AntPathRequestMatcher("/manager/**")).access("hasRole('ROLE_MANAGER') or hasRole('ROLE_ADMIN')")   // role에 의한 접근 제어
                                    .anyRequest().permitAll()
            )
//            .authorizeRequests()
////                .requestMatchers(new AntPathRequestMatcher("/member/join")).permitAll()
////                .requestMatchers(new AntPathRequestMatcher("/member/joinProc")).permitAll()
//                .anyRequest().authenticated()
//            .and()
            .formLogin()                // form 로그인 사용
            .loginPage("/member/login")        // form 로그인 페이지 url 설정(get)
            //.loginProcessingUrl("/login") // url post(지금은 필요없음)
            .defaultSuccessUrl("/board/list")     // form 로그인 성공시 이동해야 할 url
            .and()
            .logout()       // form 로그아웃(/logout)
            .logoutSuccessUrl("/member/login") // form 로그아웃 성공시 이동해야 할 url
            .and()
            .csrf().disable()       // 토큰 위조 공격 방어 사용안함
        ;

        return http.build();
    }
}
