package br.com.luis.apirest_senai.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.luis.apirest_senai.Model.Responsavel;
import br.com.luis.apirest_senai.Repository.ReponsavelRepository;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;




@RestController
@RequestMapping("/responsavel")//endereçando; quando eu criar o localhost e colocar responsavel ele fará alguma coisa
public class ResponsavelController {
    boolean acessoInternaResponsavel = false;

    @Autowired
    ReponsavelRepository repository;
    
    //quando eu der um get no responsavel ele vai no banco de dados e puxar todos os dados que estiver no banco
    @GetMapping()
    public List<Responsavel> getResponsavel () {
        return (List<Responsavel>) repository.findAll();
    }
    //login do responsavel
    @PostMapping("acesso-responsavel")
    public ModelAndView postResponsavel(@RequestParam Long id,
    RedirectAttributes attributes) {
        ModelAndView mv = new ModelAndView("redirect:/interna-responsavel");
        try{
            boolean acessoId = repository.existsById(id);

            if (acessoId) {
                String mensagem = "Login realizado com sucesso";
                System.out.println(mensagem);
                acessoInternaResponsavel =true;
                mv.addObject("msg", mensagem);
            }else{
                String mensagem = "Login não efetuado";
                System.out.println(mensagem);
                attributes.addFlashAttribute("msg", mensagem);
                mv.setViewName("redirect:/login-responsavel");
            }

        }catch(Exception e){
          String mensagem = "Login não efetuado";
          System.out.println(mensagem);
          attributes.addFlashAttribute("msg", mensagem);
          attributes.addFlashAttribute("classe", "vermelho");
          mv.setViewName("redirect:/login-adm");
        }

        return mv;
    }
 
    // @PostMapping()
    // public Responsavel postResponsavel(@RequestBody Responsavel responsavel) {
    //     return repository.save(responsavel);
    // }

    @GetMapping("/{id}")
    public Optional<Responsavel> getResponsavelById(@PathVariable Long id) {
        return repository.findById(id);
    }
    @PutMapping("/{id}")
    public Responsavel putResponsavel(  @PathVariable Long id, 
                                        @RequestBody Responsavel responsavel) {
        Optional<Responsavel> busca = repository.findById(id);
        //se procurar o id e não achar nada retorna nada para não criar id vazio
        if(!busca.isEmpty()){
            responsavel.setId(id);
            return repository.save(responsavel);
        }else{
            return null;
        }
        
    }
    @DeleteMapping("/{id}")
    public void deleteResponsavel(@PathVariable Long id){
        repository.deleteById(id);      
    }
    
}
