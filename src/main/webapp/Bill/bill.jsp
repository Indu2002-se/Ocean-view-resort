<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.buddhi.oceanviewresort.model.entity.Bill" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bill Management</title>
</head>
<body>
    <h1>Bill Management</h1>

    <% 
        String message = (String) request.getAttribute("message");
        if (message != null && !message.isEmpty()) { 
    %>
        <p style="color: green;"><%= message %></p>
    <% 
        } 
        String error = (String) request.getAttribute("error");
        if (error != null && !error.isEmpty()) { 
    %>
        <p style="color: red;"><%= error %></p>
    <% 
        } 
    %>

    <form action="<%= request.getContextPath() %>/bill" method="get">
        <label>Reservation Number:</label>
        <input type="text" name="reservationNo" required>
        <button type="submit" name="action" value="generate">Generate Bill</button>
        <button type="submit" name="action" value="view">View Bill</button>
    </form>
    
    <br/>

    <% 
        Bill bill = (Bill) request.getAttribute("bill");
        if (bill != null) { 
    %>
        <hr/>
        <h2>Bill Details</h2>
        <table border="1">
            <tr>
                <th>Bill ID</th>
                <td><%= bill.getBillId() %></td>
            </tr>
            <tr>
                <th>Reservation No</th>
                <td><%= bill.getReservationNo() %></td>
            </tr>
            <tr>
                <th>Amount</th>
                <td>$<%= String.format("%.2f", bill.getAmount()) %></td>
            </tr>
            <tr>
                <th>Issue Date</th>
                <td><%= bill.getIssueDate() %></td>
            </tr>
            <tr>
                <th>Status</th>
                <td><%= bill.getStatus() %></td>
            </tr>
        </table>
    <% 
        } 
    %>
    
    <br/>
    <a href="<%= request.getContextPath() %>/index.jsp">Back to Home</a>
</body>
</html>
