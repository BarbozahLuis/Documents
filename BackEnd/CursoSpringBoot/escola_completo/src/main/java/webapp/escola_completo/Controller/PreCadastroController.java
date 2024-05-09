package webapp.escola_completo.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import webapp.escola_completo.Model.Aluno;
import webapp.escola_completo.Model.PreCadastro;
import webapp.escola_completo.Model.Professor;
import webapp.escola_completo.Repository.AlunoRepository;
import webapp.escola_completo.Repository.PreCadastroRepository;
import webapp.escola_completo.Repository.VerificaCadastroAdmRepository;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PreCadastroController {
    // atributos

    @Autowired
    private PreCadastroRepository pcr;
    

    // métodos
    
    @PostMapping("pre-cadastro")
    public ModelAndView preCadastroBD(PreCadastro preCadastro) {

        ModelAndView mv = new ModelAndView("interna/interna-adm");
       
            pcr.save(preCadastro);
            String mensagem = "Pre Cadastro Realizado com sucesso";
            System.out.println(mensagem);
            mv.addObject("msg", mensagem);
            mv.addObject("classe", "verde");
        

        return mv;
    }
  
    


}
