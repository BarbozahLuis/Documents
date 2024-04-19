import 'package:path/path.dart';
import 'package:sa3_somativa/Model/Usuario.dart'; // Importação do modelo de usuário
import 'package:sqflite/sqflite.dart';

class BancoDadosCrud {
  static const String List_BD = 'userlista.db'; // Nome do banco de dados
  static const String User_Tabela = 'user_list'; // Nome da tabela
  static const String Script_Criacao_Tabela = // Script SQL para criar a tabela
      "CREATE TABLE IF NOT EXISTS user_list(" +
          "id SERIAL PRIMARY KEY," + 
          "nome TEXT," +
          "email TEXT UNIQUE, " +
          "senha TEXT)";

  // Método para obter o banco de dados
  Future<Database> _getDatabase() async {
    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), List_BD),
        onCreate: (db, version) async {
          try {
            await db.execute(Script_Criacao_Tabela);
            print('Tabela criada com sucesso');
          } catch (e) {
            print('Erro ao criar tabela: $e');
            // Aqui você pode tratar o erro, como lançar uma exceção ou lidar com ele de outra forma
          }
        },
        version: 1,
      );
      return db;
    } catch (e) {
      print('Erro ao abrir o banco de dados: $e');
      rethrow; // Para repassar a exceção e lidar com ela em níveis superiores
    }
  }

  // Método para criar um novo usuário no banco de dados
  Future<void> create(Usuario usuario) async {
    try {
      final Database db = await _getDatabase();
      await db.insert(User_Tabela, usuario.toMap()); // Insere o usuário no banco de dados
    } catch (ex) {
      print(ex);
      return;
    }
  }

  // Método para obter um usuário pelo email e senha
  Future<Usuario?> getUsuario(String email, String senha) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(User_Tabela,
          where: 'email = ? AND senha = ?',
          whereArgs: [email, senha]); // Consulta usuário na tabela

      if (maps.isNotEmpty) {
        return Usuario.fromMap(maps[0]);
      } else {
        return null;
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  // Método para verificar se um usuário existe pelo email e senha
  Future<bool> existsUsuario(String email, String senha) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(User_Tabela,
          where: 'email = ? AND senha = ?',
          whereArgs: [email, senha]); // Consulta usuário na tabela

      if (maps.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future<bool> existsEmail(String email) async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> maps = await db.query(User_Tabela,
          where: 'email = ?',
          whereArgs: [email]); // Consulta usuário na tabela

      if (maps.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      print(ex);
      return false;
    }
  }
}
