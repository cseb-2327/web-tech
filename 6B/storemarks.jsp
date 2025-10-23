<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Store Marks</title>
  <style>
    body { color: blue; font-family: courier; text-align: center; }
  </style>
</head>
<body>
  <h2>Store Marks Result</h2><hr/>

<%
String rno = request.getParameter("rno");
String name = request.getParameter("name");
String npm = request.getParameter("npm");
String ooad = request.getParameter("ooad");
String cns = request.getParameter("cns");
String es = request.getParameter("es");
String wt = request.getParameter("wt");
String sre = request.getParameter("sre");

if (rno != null && !rno.trim().isEmpty()) {
    try {
        // Load JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Connect to MySQL (username: root, password: blank)
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examDB", "root", "");
        
        // Prepare SQL Insert
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO markTab (rno, name, npm, ooad, cns, es, wt, sre) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        );
        ps.setString(1, rno);
        ps.setString(2, name);
        ps.setInt(3, Integer.parseInt(npm));
        ps.setInt(4, Integer.parseInt(ooad));
        ps.setInt(5, Integer.parseInt(cns));
        ps.setInt(6, Integer.parseInt(es));
        ps.setInt(7, Integer.parseInt(wt));
        ps.setInt(8, Integer.parseInt(sre));
        
        int i = ps.executeUpdate();
        
        if (i > 0) {
            out.println("<p>Marks inserted successfully for Reg.No: " + rno + "</p>");
        } else {
            out.println("<p>Failed to insert record.</p>");
        }
        
        con.close();
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
} else {
    out.println("<p>Please enter a valid registration number.</p>");
}
%>

<br/><br/>
<a href="enterMarks.html">Back</a> | <a href="stud.html">View Result</a>
</body>
</html>
