<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Manager.ShopProductDBBean" %>
<%@ page import="Manager.ShopProductDataBean" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%
   int proCode = Integer.parseInt(request.getParameter("proCode"));
   String ip = request.getParameter("ip");
   
   pageContext.getSession().setAttribute("proCode", proCode);
   pageContext.getSession().setAttribute("ip", ip);

  
   String pageNum = request.getParameter("pageNum");
   
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

   try{
	   ShopProductDBBean productProcess = ShopProductDBBean.getInstance(); 
     
    
      int checkk = productProcess.updater(proCode,ip);

       String ck =   String.valueOf(checkk);
       pageContext.getSession().setAttribute("ck", ck);

       ShopProductDataBean product = productProcess.getProduct(proCode);
      
      
      response.sendRedirect("proInfo.jsp?proCode="+proCode);
      
 %>
 <%
  }catch(Exception e){} 
  %> 
   
