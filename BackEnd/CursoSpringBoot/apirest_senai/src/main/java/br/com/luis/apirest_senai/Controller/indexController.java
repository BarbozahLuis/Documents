package br.com.luis.apirest_senai.Controller;

import org.springframework.web.bind.annotation.GetMapping;

public class indexController {
    @GetMapping("/")
    public String acessoHome() {
        return "login/login-responsavel";
    }
   
}
