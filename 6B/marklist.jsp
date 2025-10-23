<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Examination Result</title>
  <style>
    body {
      color: blue;
      font-family: courier;
      text-align: center;
    }
    table {
      margin: auto;
      border-collapse: collapse;
      width: 60%;
    }
    th, td {
      border: 1px solid blue;
      padding: 8px;
      text-align: center;
    }
    th {
      background-color: #e0e0ff;
    }
  </style>
</head>
<body>
  <h2>EXAMINATION RESULT</h2>
  <hr/>

<%
String regno = request.getParameter("regno");

if (regno != null && !regno.trim().isEmpty()) {
    try {
        // Load JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to MySQL
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examDB", "root", "");

        // Prepare query
        PreparedStatement ps = con.prepareStatement("SELECT * FROM markTab WHERE rno = ?");
        ps.setString(1, regno);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
%>
  <h3>Student Details</h3>
  Register No: <%= rs.getString("rno") %><br/>
  Name: <%= rs.getString("name") %><br/><br/>

  <table>
    <tr><th>SUBJECT</th><th>MARK</th></tr>
    <tr><td>Network Programming and Management</td><td><%= rs.getInt("npm") %></td></tr>
    <tr><td>Object Oriented Analysis and Design</td><td><%= rs.getInt("ooad") %></td></tr>
    <tr><td>Cryptography and Network Security</td><td><%= rs.getInt("cns") %></td></tr>
    <tr><td>Embedded Systems</td><td><%= rs.getInt("es") %></td></tr>
    <tr><td>Web Technology</td><td><%= rs.getInt("wt") %></td></tr>
    <tr><td>Software Requirement and Engineering</td><td><%= rs.getInt("sre") %></td></tr>
  </table>
<%
        } else {
            out.println("<p>No record found for Reg.No: " + regno + "</p>");
        }

        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
} else {
    out.println("<p>Please enter a valid registration number.</p>");
}
%>

<br/><br/>
<a href="stud.html">Back</a>
</body>
</html>
