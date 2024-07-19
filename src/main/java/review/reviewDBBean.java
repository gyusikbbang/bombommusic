package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class reviewDBBean {
	
	private static reviewDBBean instance 
    = new reviewDBBean();
	
	public static reviewDBBean getInstance() {
        return instance;
    }
	
	private reviewDBBean() {}
	
//  커넥션풀로부터 커넥션객체를 얻어내는 메소드
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/BomBom");
        return ds.getConnection();
    }
 
    
    //검색 수정안한 상태임
    public int searchcount (String proCate,String proName)
		    throws Exception {
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;
		        int x=0;
		        
		        try {
		            conn = getConnection();
		            
		            String sql1 = "SELECT count(*) FROM product WHERE proName LIKE ? ";
		            String sql2 = "select count(*) from product ";
		            sql2 += "where proCate = ? and proName LIKE  ?";
		            
		            if(proCate.equals("all")){
		                
		            	 pstmt = conn.prepareStatement(sql1);
		                 
		                
		                 pstmt.setString(1, "%" + proName + "%");
		            
		                 
		            }else{
		                pstmt = conn.prepareStatement(sql2);
		                pstmt.setString(1, proCate);
		                pstmt.setString(2, "%" + proName + "%");
			            
		             
		            }
		        	rs = pstmt.executeQuery();
		            
		            if (rs.next()) {
		               
		                do{
		                	x= rs.getInt(1);
					    }while(rs.next());
					}
		        } catch(Exception ex) {
		            ex.printStackTrace();
		        } finally {
		            if (rs != null) 
		            	try { rs.close(); } catch(SQLException ex) {}
		            if (pstmt != null) 
		            	try { pstmt.close(); } catch(SQLException ex) {}
		            if (conn != null) 
		            	try { conn.close(); } catch(SQLException ex) {}
		        }
				return x;
		    }
    
    
 // 전체등록된 책의 수를 얻어내는 메소드
 	public int recount(int proCode)
     throws Exception {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;

         int x=0;

         try {
             conn = getConnection();
             
             String sql = "select count(*) from review where proCode = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setInt(1,proCode);
             rs = pstmt.executeQuery();
             if (rs.next()) 
                x= rs.getInt(1);
         } catch(Exception ex) {
             ex.printStackTrace();
         } finally {
             if (rs != null) 
             	try { rs.close(); } catch(SQLException ex) {}
             if (pstmt != null) 
             	try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) 
             	try { conn.close(); } catch(SQLException ex) {}
         }
 		return x;
     }
  
    
}	
	
	
	
	
	
	
	
	
	
	
	
	

