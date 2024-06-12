package br.com.luis.apirest_senai.Controller;

import org.springframework.web.bind.annotation.GetMapping;

public class indexController {
    @GetMapping("/login-responsavel")
    public String acessoLoginResponsavel() {
        return "login/login-responsavel";
    }
}
