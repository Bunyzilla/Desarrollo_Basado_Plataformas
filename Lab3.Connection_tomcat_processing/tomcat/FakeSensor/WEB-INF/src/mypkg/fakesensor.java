/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package fakeSensor;
import java.sql.*;
import java.util.*;
import java.sql.*;
import java.io.*;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.http.*;

/**
 *
 * @author FMR
 */
public class fakesensor extends HttpServlet {
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
		String head ="<sensor_table>";
		String tail = "</sensor_table>";
		String fakeTemp = "<Sensor><TimeStamp>2010-09-0708:41:42.0</TimeStamp><Sensor_Id>1</Sensor_Id><Sensor_Name>Temp</Sensor_Name> <Sensor_Value>0.307000011205673</Sensor_Value><Sensor_Flag>true</Sensor_Flag></Sensor>";		
		String fakeLight = "<Sensor><TimeStamp>2010-09-0708:41:42.0</TimeStamp><Sensor_Id>2</Sensor_Id><Sensor_Name>Light</Sensor_Name> <Sensor_Value>0.197999998927116</Sensor_Value><Sensor_Flag>true</Sensor_Flag></Sensor>";		
		String fakeVibration = "<Sensor><TimeStamp>2010-09-0708:41:42.0</TimeStamp><Sensor_Id>3</Sensor_Id><Sensor_Name>Vibration</Sensor_Name> <Sensor_Value>0.509999990463257</Sensor_Value><Sensor_Flag>false</Sensor_Flag></Sensor>";		
		String fakeWeight = "<Sensor><TimeStamp>2010-09-0708:41:42.0</TimeStamp><Sensor_Id>4</Sensor_Id><Sensor_Name>Weight</Sensor_Name> <Sensor_Value>0.980000019073486</Sensor_Value><Sensor_Flag>true</Sensor_Flag></Sensor>";		
		String fakeProximity = "<Sensor><TimeStamp>2010-09-0708:41:42.0</TimeStamp><Sensor_Id>5</Sensor_Id><Sensor_Name>Proximity</Sensor_Name> <Sensor_Value>0.017000000923872</Sensor_Value><Sensor_Flag>false</Sensor_Flag></Sensor>";
        
		String name = "param";
        String value = request.getParameter(name);		

        response.setContentType("text/xml");

		PrintWriter pagina = response.getWriter();
		pagina.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");

try{
			if ("0".equals(value)) {
				pagina.write(head);
				pagina.write(fakeLight);
				pagina.write(fakeVibration);
				pagina.write(fakeWeight);
				pagina.write(fakeProximity);
				pagina.write(tail);
            } 
			else if("1".equals(value)) pagina.write(head+fakeTemp+tail); 
			else if("2".equals(value)) pagina.write(head+fakeLight+tail);
			else if("3".equals(value)) pagina.write(head+fakeVibration+tail);	
			else if("4".equals(value)) pagina.write(head+fakeWeight+tail);
			else if("5".equals(value)) pagina.write(head+fakeProximity+tail);			
			else{				
				 response.setContentType("text/html;charset=UTF-8");      
       // Write the response message, in an HTML page
  
         pagina.println("<!DOCTYPE html>");
         pagina.println("<html><head>");
         pagina.println("<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>");
         pagina.println("<title>Hello, Sensor</title></head>");
         pagina.println("<body>");
         pagina.println("<h1>Hello, sensor!</h1>");  // says Hello
         // Echo client's request information
         pagina.println("<p>Request URI: " + request.getRequestURI() + "</p>");
         pagina.println("<p>Protocol: " + request.getProtocol() + "</p>");
         pagina.println("<p>PathInfo: " + request.getPathInfo() + "</p>");
         pagina.println("<p>Remote Address: " + request.getRemoteAddr() + "</p>");
         // Generate a random number upon each request
         pagina.println("<p>A Random Number: <strong>" + Math.random() + "</strong></p>");
         pagina.println("</body>");
         pagina.println("</html>");
      } 				
			} finally{
			   pagina.close();           
			} 
}

/*Unimplemented methods*/

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}