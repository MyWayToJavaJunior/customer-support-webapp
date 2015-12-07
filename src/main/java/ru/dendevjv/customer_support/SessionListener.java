package ru.dendevjv.customer_support;

//import java.text.SimpleDateFormat;
//import java.util.Date;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionIdListener;
import javax.servlet.http.HttpSessionListener;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@WebListener
public class SessionListener implements HttpSessionListener, HttpSessionIdListener {
    
    private static final Logger log = LogManager.getLogger();
    
//    private SimpleDateFormat formatter = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss");

    /* HttpSessionListener methods */
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        log.info("Session " + se.getSession().getId() + " created");
        SessionRegistry.addSession(se.getSession());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        log.info("Session " + se.getSession().getId() + " destroyed");
        SessionRegistry.removeSession(se.getSession());
    }
    
    /* HttpSessionIdListener method */
    @Override
    public void sessionIdChanged(HttpSessionEvent se, String oldSessionId) {
        log.info("Session " + oldSessionId + " changed to " + se.getSession().getId());
        SessionRegistry.updateSessionId(se.getSession(), oldSessionId);
    }

//    private String date() {
//        return this.formatter.format(new Date());
//    }
}
