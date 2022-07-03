package org.antlr.v4.server;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.eclipse.jetty.http.HttpParser;
import org.eclipse.jetty.server.*;
import org.eclipse.jetty.server.handler.AbstractHandler;
import org.eclipse.jetty.server.handler.ContextHandler;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import org.eclipse.jetty.util.thread.QueuedThreadPool;
import org.eclipse.jetty.webapp.WebAppContext;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;

public class ANTLRHttpServer {
	public static class HelloWorldServlet extends HttpServlet {
		@Override
		public void doPost(HttpServletRequest request, HttpServletResponse response)
				throws IOException {
			response.setContentType("text/plain;charset=utf-8");
			response.setContentType("text/html;");
			response.getWriter().println("<h1>Hello world!</h1>");

			System.out.println(request.getParameterMap());

//			JsonReader jsonReader = Json.createReader(request.getReader());
			String data = request.getParameter("data");
			JsonReader jsonReader = Json.createReader(new StringReader(data));
			JsonObject jobj = jsonReader.readObject();
			System.out.println(jobj);
		}
	}


	public static void main(String[] args) throws Exception {
//		QueuedThreadPool threadPool = new QueuedThreadPool();
//		threadPool.setName("server");
//		Server server = new Server(threadPool);

		Server server = new Server(8080);

		ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
		context.setContextPath("/hello");
		context.addServlet(new ServletHolder(new HelloWorldServlet()), "/*");
		server.setHandler(context);

		server.start();
	}
}
