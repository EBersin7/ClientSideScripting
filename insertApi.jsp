<%@page contentType="application/json" pageEncoding="UTF-8"%> 
<%@page language="java" import="dbUtils.DbConn"%> 
<%@page language="java" import="model.TV_Shows.*"%>
<%
    //check if logged in
    String email = (String) session.getAttribute("User_Email");
    if (email == null) {
        out.print("Cannot insert because you are not logged in.");
    } else {
        DbConn dbc = new DbConn();
        String jsonUpdateData = request.getParameter("jsonData");
        StringData errorMsgs = new StringData();

        if (jsonUpdateData == null) {
            errorMsgs.errorMsg = "Cannot insert -- no data was received";
        } else {
            errorMsgs.errorMsg = dbc.getErr();
            if (errorMsgs.errorMsg.length() == 0) { // means db connection is ok
                System.out.println("insertApi.jsp ready to insert");
                errorMsgs = TableMods.insert(JsonConversion.toStringData(jsonUpdateData), dbc); // this is the form level message
            }
        }
        out.print(JsonConversion.toJson(errorMsgs));
        dbc.close();
    }
%>