<%@page language="java" import="java.sql.*"%>
<%@page language="java" import="dbUtils.DbConn"%>
<%@page language="java" import="com.google.gson.*" %>
<%
    String strUserEmail = "";
    String strUserPwd = "";
    String logonMsg = "";
    String sql = "";
    String storedProcLike = "";

    if (request.getParameter("userEmailInput") != null) {

        strUserEmail = request.getParameter("userEmailInput");
        strUserPwd = request.getParameter("userPwdInput");

        DbConn dbc = new DbConn();

        //Statement stmt = null; // DO NOT USE a Statement object (holds the SQL with user input embedded)
        PreparedStatement prepStmt = null; // Instead, use a PreparedStatement (holds the SQL with ?s for user input)

        ResultSet results = null; // holds the result set if the SQL is SELECT

        logonMsg = dbc.getErr();
        if (logonMsg.length() == 0) {

            try {
                //results = stmt.executeQuery("select user_email, user_password from web_user order by user_email");
                sql = "select User_Name, User_Email, User_Password, User_ID, User_Role_ID from User_Info "
                        + "where User_Email = ? and User_Password = ?";

                storedProcLike = "EXEC storedProcedure with 1st parameter = \"" + strUserEmail
                        + "\" and second parameter = \"" + strUserPwd + "\"";

                //stmt = con.createStatement();
                prepStmt = dbc.getConn().prepareStatement(sql);

                //results = stmt.executeQuery(sql);
                prepStmt.setString(1, strUserEmail);
                prepStmt.setString(2, strUserPwd);
                results = prepStmt.executeQuery();

                if (results.next()) {
                    logonMsg += "Hello, " + results.getString("User_Name") + " your email is "
                            + results.getString("User_Email") + ". "
                            + "I see your password is " + results.getString("User_Password") + ". "
                            + "You are user number " + results.getString("User_ID")
                            + " with role number " + results.getString("User_Role_ID") + ".";

                    // The JSP implicit session object stores object you want to store. 
                    // What you put in the session lasts until it times out. Any page can 
                    // do a session.getAttribute to pull it back out. 
                    session.setAttribute("User_Email", results.getString("User_Email"));
                } else {
                    logonMsg += "Invalid logon.";
                }

                results.close();  // close the result set
                prepStmt.close(); // close the statement
            } catch (Exception e) {
                logonMsg += "problem creating statement & running query:" + e.getMessage();
                results.close();  // close the result set
                prepStmt.close(); // close the statement
            }
            out.print(logonMsg);
        } // db connection good
        dbc.close();

    } // postback
%>