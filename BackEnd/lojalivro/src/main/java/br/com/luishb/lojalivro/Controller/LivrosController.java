package br.com.luishb.lojalivro.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.luishb.lojalivro.Model.Livro;
import br.com.luishb.lojalivro.Repository.LivroRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
public class LivrosController {
    
    @Autowired
    LivroRepository lr;

    @GetMapping("/livros")
    public ModelAndView getLivros() {
        ModelAndView mv = new ModelAndView("livros");
        mv.addObject("livros", livroRepository.findAll());

        return mv;
    }

    @PostMapping("/livros")
    public Livro postLivro (Livro livro) {
        livroRepository.save(livro);
        
        return "/livro";
    }
    
    

}
