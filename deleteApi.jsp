<%@page contentType="application/json" pageEncoding="UTF-8"%> 
<%@page language="java" import="dbUtils.DbConn"%> 
<%@page language="java" import="model.TV_Shows.*"%> 
<%
    //check if logged in
    String email = (String) session.getAttribute("User_Email");
    if (email == null) {
        out.print("Cannot delete because you are not logged in.");
    } else {
        DbConn dbc = new DbConn();
        String deleteId = request.getParameter("id");
        String formMsg = "";

        if (deleteId == null) {
            formMsg = "Cannot delete -- no id was received";
        } else {
            formMsg = dbc.getErr();
            //good connection, execute delete
            if (formMsg.length() == 0) {
                formMsg = TableMods.deleteById(deleteId, dbc);
            }
        }
        //print and close connection
        out.print(formMsg);
        dbc.close();
    }
%>