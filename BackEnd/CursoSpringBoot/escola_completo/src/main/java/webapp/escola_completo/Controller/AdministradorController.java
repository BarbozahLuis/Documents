package webapp.escola_completo.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import webapp.escola_completo.Model.Administrador;
import webapp.escola_completo.Model.Aluno;
import webapp.escola_completo.Repository.AdministradorRepository;
import webapp.escola_completo.Repository.AlunoRepository;
import webapp.escola_completo.Repository.VerificaCadastroAdmRepository;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;


@Controller
public class AdministradorController {
    // atributos
    boolean acessoInternoAdm = false;

    @Autowired
    private AdministradorRepository ar;

    @Autowired
    private VerificaCadastroAdmRepository vcar;

    @Autowired
    private AlunoRepository al;

    // métodos
    //validando cadastro
    @PostMapping("cadastrar-adm")
    public ModelAndView cadastroAdmBD(Administrador adm) {

        boolean verificaCpf = vcar.existsById(adm.getCpf());

        ModelAndView mv = new ModelAndView("login/login-adm");

        if (verificaCpf) {
            ar.save(adm);
            String mensagem = "Cadastro Realizado com sucesso";
            System.out.println(mensagem);
            mv.addObject("msg", mensagem);
            mv.addObject("classe", "verde");
        } else {
            String mensagem = "Cadastro Não Realizado";
            System.out.println(mensagem);
            mv.addObject("msg", mensagem);
            mv.addObject("classe", "vermelho");
        }

        return mv;
    }
    //tela de acesso ao administrador
    @PostMapping("acesso-adm")
    public ModelAndView acessoAdmLogin(@RequestParam String cpf,
            @RequestParam String senha,
            RedirectAttributes attributes) {
        ModelAndView mv = new ModelAndView("redirect:/interna-adm");// página interna de acesso
        try {
            // boolean acessoCPF = cpf.equals(ar.findByCpf(cpf).getCpf());
            boolean acessoCPF = ar.existsById(cpf);
            boolean acessoSenha = senha.equals(ar.findByCpf(cpf).getSenha());

            if (acessoCPF && acessoSenha) {
                String mensagem = "Login Realizado com sucesso";
                System.out.println(mensagem);
                acessoInternoAdm = true;
                mv.addObject("msg", mensagem);
                mv.addObject("classe", "verde");
            } else {
                String mensagem = "Login Não Efetuado";
                System.out.println(mensagem);
                attributes.addFlashAttribute("msg", mensagem);
                attributes.addFlashAttribute("classe", "vermelho");
                mv.setViewName("redirect:/login-adm");
            }
            
        } catch (Exception e) {
            String mensagem = "Login Não Efetuado";
            System.out.println(mensagem);
            attributes.addFlashAttribute("msg", mensagem);
            attributes.addFlashAttribute("classe", "vermelho");
            mv.setViewName("redirect:/login-adm");
        }
        return mv;
    }

    //método criado para efetuar o logout da tela de login
    @PostMapping("/logout-adm")
    public ModelAndView logoutAdm() {
        acessoInternoAdm = false; // Definir o estado de login como falso
        return new ModelAndView("redirect:/login-adm");
    }
    
    // acesso a pagina interna do admistrador
    @GetMapping("/interna-adm")
    public ModelAndView acessoPageInternaAdm(RedirectAttributes attributes) {
        ModelAndView mv = new ModelAndView("interna/interna-adm");
        if (acessoInternoAdm) {
            System.out.println("Acesso Permitido");
        } else {
            String mensagem = "Acesso não Permitido - faça Login";
            System.out.println(mensagem);
            mv.setViewName("redirect:/login-adm");
            attributes.addFlashAttribute("msg", mensagem);
            attributes.addFlashAttribute("classe", "vermelho");
        }

        return mv;
    }

    // acesso a pagina de cadastro do aluno pelo login do adm
    @GetMapping("/cadastro_aluno")
    public ModelAndView acessoPageCadastroAluno(RedirectAttributes attributes) {
        ModelAndView mv = new ModelAndView("cadastro/cadastro_aluno");
        if (acessoInternoAdm) {
            System.out.println("Acesso Permitido");
        } else {
            String mensagem = "Acesso não Permitido - faça Login";
            System.out.println(mensagem);
            mv.setViewName("redirect:/cadastro_aluno");
            attributes.addFlashAttribute("msg", mensagem);
            attributes.addFlashAttribute("classe", "vermelho");
        }

        return mv;
    }

    //acesso a pagina de cadastro do proefssor pelo login do adm
    @GetMapping("/cadastro_professor")
    public ModelAndView acessoPageCadastroProfessor(RedirectAttributes attributes) {
        ModelAndView mv = new ModelAndView("cadastro/cadastro_professor");
        if (acessoInternoAdm) {
            System.out.println("Acesso Permitido");
        } else {
            String mensagem = "Acesso não Permitido - faça Login";
            System.out.println(mensagem);
            mv.setViewName("redirect:/cadastro_professor");
            attributes.addFlashAttribute("msg", mensagem);
            attributes.addFlashAttribute("classe", "vermelho");
        }

        return mv;
    }

    //mapping para voltar para tela anterior
    @GetMapping("/volta-interna-adm")
    public ModelAndView acessoPageVoltaInternaAdm(RedirectAttributes attributes) {
        ModelAndView mv = new ModelAndView("interna/interna-adm");
        if (acessoInternoAdm) {
            System.out.println("Acesso Permitido");
        } else {
            String mensagem = "Acesso não Permitido - faça Login";
            System.out.println(mensagem);
            mv.setViewName("redirect:/interna-adm");
            attributes.addFlashAttribute("msg", mensagem);
            attributes.addFlashAttribute("classe", "vermelho");
        }

        return mv;
    }
    // cadastrar aluno dentro da tela administrador
    @PostMapping("cadastrar-Aluno")
    public ModelAndView cadastroAlunoBD(Aluno aluno) {

        boolean verificaAluno = al.existsById(aluno.getCpf());

        ModelAndView mv = new ModelAndView("login/login-adm");

        if (verificaAluno) {
            al.save(aluno);
            String mensagem = "Cadastro Realizado com sucesso";
            System.out.println(mensagem);
            mv.addObject("msg", mensagem);
            mv.addObject("classe", "verde");
        } else {
            String mensagem = "Cadastro Não Realizado";
            System.out.println(mensagem);
            mv.addObject("msg", mensagem);
            mv.addObject("classe", "vermelho");
        }

        return mv;
    }
  
    


}
