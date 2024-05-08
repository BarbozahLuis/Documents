package webapp.escola_completo.Repository;

import org.springframework.data.repository.CrudRepository;

import webapp.escola_completo.Model.Aluno;
import webapp.escola_completo.Model.Professor;

import java.util.List;


public interface ProfessorRepository extends CrudRepository<Professor, String>{
    Professor findByCpf(String cpf);
    Professor findBySenha(String senha);

}
