<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.mongodb.client.*, org.bson.Document"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Store Marks</title>
  <style>
    body { color: blue; font-family: courier; text-align: center; }
  </style>
</head>
<body>
  <h2>Store Student Marks</h2><hr/>
<%
String rno = request.getParameter("rno");
String name = request.getParameter("name");

int npm = Integer.parseInt(request.getParameter("npm"));
int ooad = Integer.parseInt(request.getParameter("ooad"));
int cns = Integer.parseInt(request.getParameter("cns"));
int es = Integer.parseInt(request.getParameter("es"));
int wt = Integer.parseInt(request.getParameter("wt"));
int sre = Integer.parseInt(request.getParameter("sre"));

try {
    // Connect to MongoDB
    MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
    MongoDatabase db = mongoClient.getDatabase("examDB");
    MongoCollection<Document> col = db.getCollection("markTab");

    // Create a document
    Document student = new Document("rno", rno)
            .append("name", name)
            .append("npm", npm)
            .append("ooad", ooad)
            .append("cns", cns)
            .append("es", es)
            .append("wt", wt)
            .append("sre", sre);

    // Insert into collection
    col.insertOne(student);

    out.println("<p>Marks saved successfully for Reg.No: " + rno + "</p>");
    out.println("<a href='entermarks.html'>Enter Another Student</a><br/>");
    out.println("<a href='stud.html'>View Marks</a>");

    mongoClient.close();
} catch(Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
}
%>
</body>
</html>
