import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.cassandra.CassandraProperties.Request;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import webapp.spring_crud_jpa.Repository.FuncionarioRepository;

@Controller
public class FuncionarioController {
    @Autowired
    private FuncionarioRepository fr;

    @RequestMapping(value = "/funcionario", method = Request.GET)
    public String abrirfuncionario() {
        return "funcionario/funcionario";
    }

    @RequestMapping(value = "/funcionario", method = RequestMethod.POST)
    public String gravarfuncionario(Funcionario funcionario) {
        fr.save(funcionario);
        return "redirect:/funcionario";
    }
}