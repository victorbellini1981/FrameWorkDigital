package global.crud;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedList;

import conexao.Conexao;
import global.dados.Fruta;
import global.util.LogErros;

public class CRUDcad_frutas {
	
private Conexao conexao;
	
	public CRUDcad_frutas(Conexao conexao) {
		this.conexao = conexao;
		
	}
	
		
	public LinkedList<Fruta> getFrutas() {
		
		LinkedList<Fruta> lista = new LinkedList<Fruta>();
		// teste		
		try {

			String sql =	"SELECT f.idfruta, \r\n" +
							"		f.nome, \r\n" +
							"		f.preco, \r\n" +
							"		f.imagem \r\n" +
							"FROM 	frutas f;";
									
			PreparedStatement pst = conexao.sqlPreparada(sql);
			//pst.setInt(1, fruta.getIdfruta());
			ResultSet rs = conexao.executaQuery(pst);

			while (rs.next()) {
				Fruta fruta = new Fruta();
				fruta.setIdfruta(rs.getInt("idfruta"));
				fruta.setNome(rs.getString("nome"));
				fruta.setPreco(rs.getDouble("preco"));
				fruta.setImagem(rs.getString("imagem"));
				
				
				lista.add(fruta);							
			}
			
			return lista;
		} catch (Exception e) {
			LogErros log = new LogErros();
			log.gravarLogErro(e, "MOBILE", "Erro " + e.getMessage());
			return lista;
		}

	}

	
}
