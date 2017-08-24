<%@page contentType="application/json" pageEncoding="UTF-8"%> 
<%@page language="java" import="dbUtils.*"%> 
<%@page language="java" import="view.ShowView"%>
<%
/*  http://stackoverflow.com/questions/477816/what-is-the-correct-json-content-type 
     The MIME media type for JSON text is application/json. The default encoding is UTF-8. (Source: RFC 4627).
*/
    DbConn dbc = new DbConn();
    String dbError = dbc.getErr();
    String showListJson = "[ ]";
    if (dbError.length() == 0) { // Means db connection is good
        showListJson = ShowView.showListJson(dbc);
    }
    String json = "{ " + 
            FormatUtils.doubleQuoted("dbError")    + ":" + FormatUtils.doubleQuoted(dbError) + ", " + 
            FormatUtils.doubleQuoted("personList") + ":" + showListJson + "}"; 
    out.print(json);
%>