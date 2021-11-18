package server;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import global.dados.Fruta;

import global.dados.UploadArquivo;

import global.util.UploadServlet;
import global.util.Util;
import gwtupload.server.exceptions.UploadActionException;
import server.aplicativo.*;



public class Servlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {



		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		//response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-control", "no-cache, no-store");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "-1");
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "Content-Type");
		response.setHeader("Access-Control-Max-Age", "86400");

		PrintWriter out = response.getWriter();
		Gson gson = new Gson();

		String serverName = request.getServerName();
				
		
//		String serverName = "127.0.0.1";

		// Proteje contra SQL Inject
		HashMap<String, String> parametros = new HashMap<>();
		Map<String, String[]> allParameters = request.getParameterMap();
		for (String par : allParameters.keySet()) {
			parametros.put(par, request.getParameter(par).replace("'", "`"));
		}
		
		

		// Lê os parametros passados
		String metodo = parametros.get("metodo");
		metodo = metodo == null ? "index" : metodo;

		System.out.println("METODO -> " + metodo + " | Banco -> " + serverName);

		// APLICATIVO -------------------------------------
		if (metodo.equals("GetVersaoMobile")) {
			retornaObj(out, gson.toJsonTree("teste"));
		}
		
		else if (metodo.equals("GetFrutas")) {
			CRUDfruta crud_fruta = new CRUDfruta(serverName);
			//Fruta fruta = gson.fromJson(parametros.get("obj"), Fruta.class); 
			retornaObj(out , gson.toJsonTree(crud_fruta.getFrutas()));
		}
		
		// -------------------------------------------------
		else {
			retornaObj(out, gson.toJsonTree("Parâmetros Inválidos!"));
		}

		out.close();

	}


	
	public void retornaObj(PrintWriter out, JsonElement jsonElement) {
		JsonObject myObj = new JsonObject();

		JsonElement jsonObj = jsonElement;
		myObj.add("dados", jsonObj);
		out.println(jsonObj.toString());
	}
	
	private String uploadArquivos(HttpServletRequest request, HashMap<String, String> data) {
		String retorno = "";
		UploadArquivo uploadArquivo = new UploadArquivo();
		try {
			DiskFileItemFactory diskFactory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(diskFactory);
			List<FileItem> items;
			items = upload.parseRequest(request);

			for (FileItem item : items) {
				if (item.isFormField()) {
				} else {
					if (item.getSize() != 0) {
						retorno = uploadArquivo.upload(request, item, data.get("nomeArquivo"), data.get("caminho"), data.get("tipo"));
					}
				}
			}
		} catch (FileUploadException e) {
			retorno = "FileUploadException: "+e.getMessage();
			e.printStackTrace();
		} catch (UploadActionException e) {
			retorno = "UploadActionException: "+e.getMessage();
			e.printStackTrace();
		}
		return retorno;
	}
	
		
	}
