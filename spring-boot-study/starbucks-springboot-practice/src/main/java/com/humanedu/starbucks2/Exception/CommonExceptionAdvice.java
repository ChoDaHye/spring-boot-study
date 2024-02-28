package com.humanedu.starbucks2.Exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class CommonExceptionAdvice {
    @ExceptionHandler(Exception.class)
    public String except(Exception ex, Model model) {
        model.addAttribute("exception", ex);
        System.out.println("exception: " + ex.getMessage());

        return "error_page";
    }
}
