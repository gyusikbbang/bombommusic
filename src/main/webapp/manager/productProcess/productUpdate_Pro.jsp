<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Manager.ShopProductDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<% request.setCharacterEncoding("utf-8");%>

<%
String realFolder = "";//웹 어플리케이션상의 절대 경로
String []filename1 = new String[4];


MultipartRequest imageUp = null; 

String saveFolder = "/imageFile";//파일이 업로드되는 폴더를 지정한다.
String encType = "utf-8"; //엔코딩타입
int maxSize = 50*1024*1024;  //최대 업로될 파일크기 5Mb
//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
ServletContext context = getServletContext();
realFolder = context.getRealPath(saveFolder);  


try{
   
	//전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
    //전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
    imageUp = new MultipartRequest(
		 request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
    
  
    //전송한 파일 정보를 가져와 출력한다
    
    Enumeration<?> ProImg1 = imageUp.getFileNames();
    String[] name1  =new String[4];
   
     int i =0;
    //파일 정보가 있다면
    while(ProImg1.hasMoreElements() ){
      //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
     name1[i]= (String)ProImg1.nextElement();

     
      //서버에 저장된 파일 이름
      filename1[i] = imageUp.getFilesystemName(name1[i]);
      
      
     
      i++;
    }
}catch(IOException ioe){
 System.out.println(ioe);
}catch(Exception ex){
 System.out.println(ex);
}
%>

<jsp:useBean id="Product" scope="page" 
     class="Manager.ShopProductDataBean">
</jsp:useBean>

<%
 int proCode= Integer.parseInt( imageUp.getParameter("ProCode"));
String ProCate = imageUp.getParameter("ProCate");
String ProName = imageUp.getParameter("ProName");
String ProLabel = imageUp.getParameter("ProLabel");
String Price = imageUp.getParameter("Price");
String ProInfo = imageUp.getParameter("ProInfo");
String ProStock = imageUp.getParameter("ProStock");
String Concerto = imageUp.getParameter("Concerto");
String discount_rate = imageUp.getParameter("discount_rate");



 Price = Price.replaceAll("[^0-9]", "");


 Product.setProCate(ProCate);
 Product.setProName(ProName);
 Product.setProLabel(ProLabel);
 Product.setConcerto(Boolean.parseBoolean(Concerto));
 Product.setPrice(Integer.parseInt(Price));

 Product.setProImg1(filename1[3]);
 Product.setProImg2(filename1[1]);
 Product.setProImg3(filename1[0]);
 Product.setDiscount_rate(Integer.parseInt(discount_rate));
 Product.setAudio(filename1[2]);
 Product.setProInfo(ProInfo);

 Product.setProStock(ProStock);
                   
 Product.setRegdate(new Timestamp(System.currentTimeMillis()));
 

ShopProductDBBean productProcess = ShopProductDBBean.getInstance();
productProcess.updateProduct(Product, proCode); 

response.sendRedirect("/BomBom/manager/productProcess/productList.jsp?proCate="+ProCate);



%>