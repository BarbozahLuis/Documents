package webapp.escola_completo.Repository;

import org.springframework.data.repository.CrudRepository;

import webapp.escola_completo.Model.Administrador;

public interface AdministradorRepository extends CrudRepository<Administrador, String> { //marcar dentra da <> o valor do ID neste caso string pois a primary key é o cpf 
    Administrador findByCpf(String cpf);

    
} 
