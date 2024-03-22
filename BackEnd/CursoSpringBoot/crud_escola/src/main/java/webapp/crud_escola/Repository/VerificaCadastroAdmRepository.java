package webapp.crud_escola.Repository;

import org.springframework.data.repository.CrudRepository;

import webapp.crud_escola.Model.VerificaCadastroAdm;

//a classe interface não precisa implementar metodos, os metodos são implementados pelo crud repository 
public interface VerificaCadastroAdmRepository extends CrudRepository<VerificaCadastroAdm, String>{
    
    VerificaCadastroAdm findByCpf (String cpf);

    VerificaCadastroAdm findByNome (String nome);
}
