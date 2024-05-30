package br.com.luis.apirest_senai.Model;

import java.io.Serializable;

import org.hibernate.annotations.ManyToAny;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Ambiente implements Serializable {//classe ambiente modelo para banco de dados
    //atributos
    @Id
    private Long id;

    private String nome;

    @ManyToOne //muitos em um - para varios ambiente posso ter apenas um responsavel
    @JoinColumn(name = "id_responsavel")//nome da coluna que estou criando para quando for criado como se fosse uma forengn key puxando um id de outra tabela
    private Responsavel responsavel; //criando um objeto da classe responsavel esteja na coluna id responsavel


}
