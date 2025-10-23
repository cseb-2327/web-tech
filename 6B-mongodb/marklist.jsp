<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.mongodb.client.*, org.bson.Document, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Three Tier Application</title>
  <style>
    body { color: blue; font-family: courier; text-align: center; }
  </style>
</head>
<body>
  <h2>EXAMINATION RESULT</h2><hr/>

<%
String regno = request.getParameter("regno");

if (regno != null && !regno.trim().isEmpty()) {
    try {
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase db = mongoClient.getDatabase("examDB");
        MongoCollection<Document> col = db.getCollection("markTab");

        Document student = col.find(new Document("rno", regno)).first();

        if (student != null) {
%>
  Register No: <%= student.getString("rno") %><br/>
  Name: <%= student.getString("name") %><br/><br/>
  <table border="1" align="center">
    <tr><th>SUBJECT</th><th>Mark</th></tr>
    <tr><td>Network Programming and Management</td><td><%= student.getInteger("npm") %></td></tr>
    <tr><td>Object Oriented Analysis and Design</td><td><%= student.getInteger("ooad") %></td></tr>
    <tr><td>Cryptography and Network Security</td><td><%= student.getInteger("cns") %></td></tr>
    <tr><td>Embedded Systems</td><td><%= student.getInteger("es") %></td></tr>
    <tr><td>Web Technology</td><td><%= student.getInteger("wt") %></td></tr>
    <tr><td>Software Requirement and Engineering</td><td><%= student.getInteger("sre") %></td></tr>
  </table>
<%
        } else {
            out.println("<p>No record found for Reg.No: " + regno + "</p>");
        }

        mongoClient.close();
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    }
} else {
    out.println("<p>Please enter a valid registration number.</p>");
}
%>

<br/><br/>
<a href="stud.html">Back</a>
</body>
</html>
