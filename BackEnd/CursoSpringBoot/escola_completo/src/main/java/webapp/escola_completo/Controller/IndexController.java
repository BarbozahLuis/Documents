package webapp.escola_completo.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class IndexController {
    //classe para criação das rotas de navegaçã
    
    //sempre que eu clicar no "home" sempre vai direto pra pagina index
    @GetMapping("/home")
    public String acessoHomePage() {
        return "index";
    }

    @GetMapping("")
    public String acessoHomePage2() {
        return "index";
    }
    
}
