<%@ page import="com.mongodb.client.*, org.bson.Document, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>Online Exam Result</title>
<style>
body { background-color: black; color: blue; font-family: courier; text-align: center; }
</style>
</head>
<body>
<h2>ONLINE EXAM RESULT</h2>
<hr/>

<%
String str1 = request.getParameter("ans1");
String str2 = request.getParameter("ans2");
String str3 = request.getParameter("ans3");
int mark = 0;

try {
    // Connect to MongoDB
    MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
    MongoDatabase db = mongoClient.getDatabase("examDB");
    MongoCollection<Document> col = db.getCollection("examTab");

    List<Document> answers = col.find().into(new ArrayList<Document>());

    if (answers.size() >= 3) {
        if (str1 != null && str1.equalsIgnoreCase(answers.get(0).getString("answer"))) mark += 5;
        if (str2 != null && str2.equalsIgnoreCase(answers.get(1).getString("answer"))) mark += 5;
        if (str3 != null && str3.equalsIgnoreCase(answers.get(2).getString("answer"))) mark += 5;
    }

    out.println("<h3>Your Mark: " + mark + "</h3>");
    if (mark >= 10)
        out.println("<h3>Congratulations! You are eligible for the next round.</h3>");
    else
        out.println("<h3>Sorry! You are not eligible for the next round.</h3>");

    mongoClient.close();
} catch (Exception e) {
    out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
}
%>

<br/><br/>
<a href="ExamClient.html" style="color: lightblue;">Back</a>
</body>
</html>
