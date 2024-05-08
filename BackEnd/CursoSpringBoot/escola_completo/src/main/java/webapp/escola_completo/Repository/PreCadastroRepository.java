package webapp.escola_completo.Repository;

import org.springframework.data.repository.CrudRepository;

import webapp.escola_completo.Model.Aluno;
import webapp.escola_completo.Model.PreCadastro;

import java.util.List;


public interface PreCadastroRepository extends CrudRepository<PreCadastro, String>{
    PreCadastro findByCpf(String cpf);
    PreCadastro findBySenha(String senha);
}
