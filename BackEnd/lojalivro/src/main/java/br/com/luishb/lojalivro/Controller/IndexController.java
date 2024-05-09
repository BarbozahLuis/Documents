package br.com.luishb.lojalivro.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class IndexController {
    
    @GetMapping("/")
    public String getHome() {
        return ("/index");
    }
    
    @GetMapping("/")
    public String getIndex() {
        return ("/index");
    }
}
