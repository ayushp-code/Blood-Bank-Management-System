package com.bb;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddDonorServlet")
public class AddDonorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String group = request.getParameter("blood_group");
        String phone = request.getParameter("phone");
        String city = request.getParameter("city");
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO donor(name,age,blood_group,phone,city) VALUES(?,?,?,?,?)");
            ps.setString(1, name);
            ps.setInt(2, age);
            ps.setString(3, group);
            ps.setString(4, phone);
            ps.setString(5, city);
            ps.executeUpdate();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("dashboard.jsp");
    }
}