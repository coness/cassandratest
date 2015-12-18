<%@ page import="com.datastax.driver.core.Cluster" %>
<%@ page import="com.datastax.driver.core.Metadata" %>
<%@ page import="com.datastax.driver.core.Row" %>
<%@ page import="com.datastax.driver.core.Session" %>
<%@ page import="com.datastax.driver.core.ResultSet" %>
<%@ page import="com.datastax.driver.core.Statement" %>
<%@ page import="com.datastax.driver.core.querybuilder.QueryBuilder" %>
<%@ page import="java.util.UUID" %>

<%
	//Create cluster connection to local server
	Cluster cluster = Cluster.builder()
		.addContactPoints("127.0.0.1")
		.build();

	//Only used for getting cluster information
	Metadata metadata = cluster.getMetadata();
        
	//Test to see if we connected to the Cluster		
	out.println("Cassandra Cluster Connected To: " + metadata.getClusterName() + 
				", Driver Version: " + cluster.getDriverVersion());

	//Select from videdb cluster and videos table
	Statement statement = QueryBuilder.select()
    	.all()
       	.from("videodb","videos");
//		.where(eq("videoid",""))

	//Execute select statement to get recordset		
	String option = request.getParameter("video_select");
	out.println(option);

/*
	response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires", 0);
*/
%>

<html>
<head>
	<style type="text/css">
		tr:nth-child(2n){
			background-color:#53C9CE;
		}
	</style>
</head>
<body>
<form name="frmVideos" id="video" action="index.jsp">
	<br><br>
	<table border=1>
		<tr>
			<!--td>
				<select id="video_select">
					<%
//						ResultSet rs = cluster.connect().execute(statement);
//				        for (Row row : rs ){        	
//				        	out.println("<option value="+ row.getString("videoname") +">" + row.getString("videoname") + "</option>");
//				        }					
					%>
				</select>
			</td>
			<td><button>Submit</button></td-->
		</tr>
		<tr style="background:#000000"><td colspan=2>&nbsp;</td></tr>
		<tr style="background:#C0C0C0">
			<td>VideoName</td>
			<td>Description</td>
		</tr>
		<% //Loop through and print out recordset
			ResultSet rs2 = cluster.connect().execute(statement);    
			
			for (Row row : rs2 ){        	
	        	out.println("<tr>");
	        	out.println("<td>" + row.getString("videoname") + "</td>");
	        	out.println("<td>" + row.getString("description") + "</td>");
	        	out.println("</tr>");
	        }
		%>
	</table>
</form>
</body>
</html>

<%
	//Clean up after ourselves		
	cluster.close();
%>