<%@page contentType="text/html" language="java" import="java.sql.*"%>
<html>
<head>
<title>Online Exam Server</title>
<style type="text/css">
   body { background-color: black; font-family: courier; color: blue; }
</style>
</head>
<body>
<h2 style="text-align:center">ONLINE EXAMINATION</h2>
<p><a href="ExamClient.html">Back To Main Page</a></p>
<hr/>

<%
String str1 = request.getParameter("ans1");
String str2 = request.getParameter("ans2");
String str3 = request.getParameter("ans3");
int mark = 0;

try {
    // ✅ Load MySQL JDBC Driver
    Class.forName("com.mysql.cj.jdbc.Driver");

    // ✅ Connect to MySQL Database (examDB)
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/examDB", "root", "");

    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM examTab");

    int i = 1;
    while (rs.next()) {
        String correctAnswer = rs.getString("answer");

        if (i == 1 && str1 != null && str1.equals(correctAnswer)) mark += 5;
        if (i == 2 && str2 != null && str2.equals(correctAnswer)) mark += 5;
        if (i == 3 && str3 != null && str3.equals(correctAnswer)) mark += 5;

        i++;
    }

    if (mark >= 10) {
        out.println("<h4>Your Mark Is : " + mark + "</h4>");
        out.println("<h3>Congratulations! You Are Eligible For The Next Round...</h3>");
    } else {
        out.println("<h4>Your Mark Is : " + mark + "</h4>");
        out.println("<h3>Sorry! You Are Not Eligible For The Next Round...</h3>");
    }

    con.close();
} catch (Exception e) {
    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
}
%>

</body>
</html>
