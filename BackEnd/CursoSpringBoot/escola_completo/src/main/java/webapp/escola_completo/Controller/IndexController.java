package webapp.escola_completo.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class IndexController {
    //classe para criação das rotas de navegação

    @GetMapping("/home")
    public ModelAndView acessoHomePage() {
        ModelAndView mv = new ModelAndView("index");
        return mv;
    }
    @GetMapping("")
    public String acessoHomePage2() {
        return "index";
    }
    @GetMapping("/login-adm")
    public String acessoLoginAdm() {
        return "login/login-adm";
    }
    @GetMapping("/cadastro-adm")
    public String acessoCadastroAdm() {
        return "cadastro/cadastro-adm";
    }
    @GetMapping("/login-aluno")
    public String acessoLoginAluno(){
        return "login/login-aluno";
    }
    @GetMapping("/login-prof")
    public String acessoLoginProfessor(){
        return "login/login-prof";
    }
    // @GetMapping("/interna-adm")
    // public String acessoInternaAdm(){
    //     return "interna/interna-adm";
    // }
    // @GetMapping("/interna-aluno")
    // public String acessoInternaAluno(){
    //     return "interna/interna-aluno";
    // }
    // @GetMapping("/interna-prof")
    // public String acessoInternaProfessor(){
    //     return "interna/interna-prof";
    // }
    
    
    
}
