package server.aplicativo;

import java.util.LinkedList;

import conexao.Conexao;
import global.crud.CRUDcad_frutas;
import global.dados.Fruta;
import global.dados.Retorno;
import global.util.LogErros;
import global.util.Util;

public class CRUDfruta {
	
	private String serverName;

	public CRUDfruta(String serverName) {
		this.serverName = serverName;
	}
	
	public Retorno getFrutas() {
		Conexao conexao = new Conexao(serverName);
		Util u = new Util();
		
		try {
			CRUDcad_frutas crud_fruta = new CRUDcad_frutas(conexao);
			LinkedList<Fruta> frutas = crud_fruta.getFrutas();
			return u.retorno("sucesso", "", "Sucesso ao retornar dados", frutas, null);
		} catch (Exception e) {
			LogErros log = new LogErros();
			log.gravarLogErro(e, "MOBILE", "Erro " + e.getMessage());
			return u.retorno("erro", "", "Erro ao retornar produto", null, null);
		} finally {
			conexao.desconecta();
		}
	}

}
