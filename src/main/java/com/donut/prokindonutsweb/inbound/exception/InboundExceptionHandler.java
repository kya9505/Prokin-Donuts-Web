package com.donut.prokindonutsweb.inbound.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.format.DateTimeParseException;

@Slf4j
@ControllerAdvice
public class InboundExceptionHandler {

    @ExceptionHandler(DateTimeParseException.class)
    public String dateParseException(RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("errorMessage", "날짜 형식이 올바르지 않습니다.");
        return "redirect:/wm/inbound/request";
    }

    @ExceptionHandler(UserException.class)
    public String userHandlerException(UserException e, Model model) {
        log.error("에러 출력");
        model.addAttribute("errorMessage", e.getMessage());
        return e.getErrorType().getRedirectUrl();

    }
}
