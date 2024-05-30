package br.com.luis.apirest_senai.Model;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity 
//utilizando o lombok, desta forma não é necessário criar os getters e setters pois o lombok ja cria utilizando as informações abaixo
@Setter
@Getter
public class Responsavel implements Serializable{
    //atributos
    
    @Id //para marcar como primary key na classe responsavel
    private Long id; //utilizando long para mais de 10 digitos

    private String nome;



}
