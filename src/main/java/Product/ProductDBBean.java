package Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Manager.ShopProductDataBean;

public class ProductDBBean {
	
    private static ProductDBBean instance 
                            = new ProductDBBean();
    
    public static ProductDBBean getInstance() {
        return instance;
    }
    
    private ProductDBBean() {}
    
    //  커넥션풀로부터 커넥션객체를 얻어내는 메소드
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/BomBom");
        return ds.getConnection();
    }
    
    // 전체 검색 건수
    public int searchCount (String proName, String proCate, String proLabel) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int x=0;
        
        try {
            conn = getConnection();
            
            String sql = "SELECT count(*) FROM product WHERE 1 = 1 ";
            int seq = 0;
            if(!proCate.equals("all")){
                sql += " AND proCate = ?";
            }
            
            if(!proLabel.equals("all")){
                sql += " AND proLabel = ?";
            }
            
            if(!proName.equals("")){
                sql += " AND proName LIKE ?";
            }
            
            System.out.println("[searchCount] sql : " + sql);
            
	       	 pstmt = conn.prepareStatement(sql);
	         if(!proCate.equals("all")){
	        	 seq++;
	        	 pstmt.setString(seq, proCate);
	         }
	         
	         if(!proLabel.equals("all")){
	        	 seq++;
	        	 pstmt.setString(seq, proLabel);
	         }
	         
	         if(!proName.equals("")){
	             seq++;	        	 
	        	 pstmt.setString(seq, "%" + proName + "%");
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
    
    // 상품 검색
    public List<ShopProductDataBean> searchList(String proName, String proCate, String proLabel, int start, int end) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ShopProductDataBean> productList=null;
        
        try {
            conn = getConnection();
            
            String sql = "SELECT * FROM product WHERE 1 = 1 ";
            int seq = 0;
            if(!proCate.equals("all")){
                sql += " AND proCate = ?";
            }
            
            if(!proLabel.equals("all")){
                sql += " AND proLabel = ?";
            }
            
            if(!proName.equals("")){
                sql += " AND proName LIKE ?";
            }
            
            sql += " order by regdate asc limit ?,?";
            
            System.out.println("[searchList] sql : " + sql);
            System.out.println("[searchList] start : " + start + ", end : " + end);
            
	       	 pstmt = conn.prepareStatement(sql);
	         if(!proCate.equals("all")){
	        	 seq++;
	        	 pstmt.setString(seq, proCate);
	         }
	         
	         if(!proLabel.equals("all")){
	        	 seq++;
	        	 pstmt.setString(seq, proLabel);
	         }
	         
	         if(!proName.equals("")){
	             seq++;	        	 
	        	 pstmt.setString(seq, "%" + proName + "%");
	         }
	         
	         seq++;
        	 pstmt.setInt(seq, start);
	         seq++;
        	 pstmt.setInt(seq, end);
            
	         rs = pstmt.executeQuery();
            
	         if (rs.next()) {
                productList = new ArrayList<ShopProductDataBean>();
                do{
                     ShopProductDataBean product= new ShopProductDataBean();
                     
                     product.setProCode(rs.getInt("proCode"));
                     product.setProCate(rs.getString("proCate"));
                     product.setProName(rs.getString("proName"));
                     product.setProLabel(rs.getString("proLabel"));
                     product.setPrice(rs.getInt("Price"));
                   
                     product.setProImg1(rs.getString("proImg1"));
                     product.setProImg2(rs.getString("proImg2"));
                     product.setProImg3(rs.getString("proImg3"));

                     
                     product.setProInfo(rs.getString("proInfo"));
                     product.setProStock(rs.getString("proStock"));
                     
                     product.setRegdate(rs.getTimestamp("regdate"));
                     product.setDiscount_rate(rs.getInt("discount_rate")); // hwna / 20230615
                     
                     productList.add(product);
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
		return productList;
    }
    
    // 이벤트 특가 상품 건수 (hwna / 20230614)
    public int discountSearchCount() throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int x=0;
        
        try {
            conn = getConnection();
            
            String sql = "SELECT count(*) FROM product WHERE discount_rate > 0 ";
            
            System.out.println("[discountSearchCount] sql : " + sql);
            
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			x = rs.getInt(1);

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

    // 이벤트 특가 상품 리스트 (hwna / 20230614)
    public List<ShopProductDataBean> discountSearchList(int start, int pageSize) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ShopProductDataBean> productList=null;
        
        try {
            conn = getConnection();
            
            // 신규 등록 상품 순 
            String sql = "SELECT * FROM product WHERE discount_rate > 0 ";
            sql += " order by regdate desc, proName limit ?, ?";
            
            System.out.println("[discountSearchList] sql : " + sql);
            System.out.println("[discountSearchList] start : " + start + ", pageSize : " + pageSize);
            
	       	 pstmt = conn.prepareStatement(sql);
        	 pstmt.setInt(1, start);
        	 pstmt.setInt(2, pageSize);
            
	         rs = pstmt.executeQuery();
            
	         if (rs.next()) {
                productList = new ArrayList<ShopProductDataBean>();
                do{
                     ShopProductDataBean product= new ShopProductDataBean();
                     
                     product.setProCode(rs.getInt("proCode"));
                     product.setProCate(rs.getString("proCate"));
                     product.setProName(rs.getString("proName"));
                     product.setProLabel(rs.getString("proLabel"));
                     product.setPrice(rs.getInt("Price"));
                   
                     product.setProImg1(rs.getString("proImg1"));
                     product.setProImg2(rs.getString("proImg2"));
                     product.setProImg3(rs.getString("proImg3"));
                     
                     product.setProInfo(rs.getString("proInfo"));
                     product.setProStock(rs.getString("proStock"));
                     
                     product.setRegdate(rs.getTimestamp("regdate"));
                     
                     product.setDiscount_rate(rs.getInt("discount_rate"));
                     
                     productList.add(product);
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
		return productList;
    }  
}