package ru.dendevjv.customer_support;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebServlet(
        name="ticketServlet",
        urlPatterns = {"/tickets"},
        loadOnStartup = 1
)
@MultipartConfig(
        fileSizeThreshold = 5_242_880,  // 5Mb
        maxFileSize = 20_971_520L,      // 20Mb
        maxRequestSize = 41_943_040L    // 40Mb
)
public class TicketServlet extends HttpServlet {
    private static final String CHARACTER_ENCODING = "UTF-8";

    private static final long serialVersionUID = 1L;
    
    private static final Logger log = LogManager.getLogger();
    
    private volatile int ticketIdSequence = 1;
    
    private Map<Integer, Ticket> ticketDatabase = new LinkedHashMap<Integer, Ticket>();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    log.debug("entered doGet()");
	    if (request.getSession().getAttribute("username") == null) {
	        response.sendRedirect("login");
	        return;
	    }
	    
	    request.setCharacterEncoding(CHARACTER_ENCODING);
		String action = request.getParameter("action");
		if (action == null) {
		    action = "list";
		}
		switch (action) {
		case "create":
		    showTicketForm(request, response);
		    break;
		case "view":
		    viewTicket(request, response);
		    break;
		case "download":
		    downloadAttachment(request, response);
		    break;
		case "list":
		default:
		    listTickets(request, response);
		    break;
		}
	}

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("entered doPost()");
        if (request.getSession().getAttribute("username") == null) {
            response.sendRedirect("login");
            return;
        }
        
        request.setCharacterEncoding(CHARACTER_ENCODING);
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
        case "create":
            createTicket(request, response);
            break;
        case "list":
        default:
            response.sendRedirect("tickets");
            break;
        }
    }

    private void showTicketForm(HttpServletRequest request,
            HttpServletResponse response) throws IOException, ServletException {
        log.debug("entered showTicketForm()");
        request.getRequestDispatcher("/WEB-INF/jsp/view/ticketForm.jsp")
                .forward(request, response);
    }
	
	private void viewTicket(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
	    log.debug("entered viewTicket()");
	    String idString = request.getParameter("ticketId");
	    Ticket ticket = getTicket(idString, response);
	    if (ticket == null) {
	        return;
	    }
	    
	    request.setAttribute("ticket", ticket);
	    request.getRequestDispatcher("/WEB-INF/jsp/view/viewTicket.jsp").forward(request, response);
	}
	
    private void downloadAttachment(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("entered downloadAttachment()");
        String idString = request.getParameter("ticketId");
        Ticket ticket = getTicket(idString, response);
        if (ticket == null) {
            return;
        }

        String name = request.getParameter("attachment");
        if (name == null) {
            response.sendRedirect("tickets?action=view&ticketId=" + idString);
            return;
        }

        Attachment attachment = ticket.getAttachment(name);
        if (attachment == null) {
            response.sendRedirect("tickets?action=view&ticketId=" + idString);
            return;
        }

        response.setHeader("Content-Disposition", "attachment; filename="
                + attachment.getName());
        response.setContentType("application/octet-stream");

        ServletOutputStream stream = response.getOutputStream();
        stream.write(attachment.getContents());
    }
    
    private void listTickets(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        log.debug("entered listTickets()");
        request.setAttribute("ticketDatabase", ticketDatabase);
        
        request.getRequestDispatcher("/WEB-INF/jsp/view/listTickets.jsp").forward(request, response);
    }
    
    private void createTicket(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        log.debug("entered createTicket()");
        Ticket ticket = new Ticket();
        ticket.setCustomerName((String)request.getSession().getAttribute("username"));
        ticket.setSubject(request.getParameter("subject"));
        ticket.setBody(request.getParameter("body"));

        Part filePart = request.getPart("file1");
        if (filePart != null && filePart.getSize() > 0) {
            Attachment attachment = processAttachment(filePart);
            if (attachment != null) {
                ticket.addAttachment(attachment);
            }
        }

        int id;
        synchronized (this) {
            id = this.ticketIdSequence++;
            this.ticketDatabase.put(id, ticket);
        }

        response.sendRedirect("tickets?action=view&ticketId=" + id);
    }

    private Attachment processAttachment(Part filePart) throws IOException {
        log.debug("entered processAttachment()");
        InputStream inputStream = filePart.getInputStream();
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        int read;
        final byte[] bytes = new byte[1024];

        while ((read = inputStream.read(bytes)) != -1) {
            outputStream.write(bytes, 0, read);
        }

        Attachment attachment = new Attachment();
        attachment.setName(filePart.getSubmittedFileName());
        attachment.setContents(outputStream.toByteArray());

        return attachment;
    }

    private Ticket getTicket(String idString, HttpServletResponse response) throws IOException {
        log.debug("entered getTicket()");
        if (idString == null || idString.isEmpty()) {
            response.sendRedirect("tickets");
            return null;
        }
        try {
            Ticket ticket = ticketDatabase.get(Integer.parseInt(idString));
            if (ticket == null) {
                response.sendRedirect("tickets");
                return null;
            }
            return ticket;
        } catch (Exception e) {
            response.sendRedirect("tickets");
            return null;
        }
    }
    
}
