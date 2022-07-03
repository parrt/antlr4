package org.antlr.v4.server;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.eclipse.jetty.http.HttpParser;
import org.eclipse.jetty.server.*;
import org.eclipse.jetty.server.handler.AbstractHandler;
import org.eclipse.jetty.util.thread.QueuedThreadPool;

import java.io.IOException;

public class ANTLRHttpServer {
	static class Page extends AbstractHandler {
		@Override
		public void handle(String target, Request baseRequest, HttpServletRequest request,
						   HttpServletResponse response) throws IOException, ServletException {

			response.setContentType("text/plain;charset=utf-8");
			response.setStatus(HttpServletResponse.SC_OK);
			baseRequest.setHandled(true);
			response.getWriter().println("Hello there");
		}
	}


	public static void main(String[] args) throws Exception {
		// Create and configure a ThreadPool.
		QueuedThreadPool threadPool = new QueuedThreadPool();
		threadPool.setName("server");

//		Server server = new Server(threadPool);
		Server server = new Server(8080);
		Connector connector = new ServerConnector(server);
		server.addConnector(connector);
		server.setHandler(new Page());
		server.start();
	}
}
