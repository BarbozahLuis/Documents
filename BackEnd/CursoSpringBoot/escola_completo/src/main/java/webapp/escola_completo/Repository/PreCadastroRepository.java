package webapp.escola_completo.Repository;

import org.springframework.data.repository.CrudRepository;

import webapp.escola_completo.Model.PreCadastro;


public interface PreCadastroRepository extends CrudRepository<PreCadastro, String>{
    PreCadastro findByCpf(String cpf);
}
