package Cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CartDBBean {
	private static CartDBBean instance = new CartDBBean();
	   
    public static CartDBBean getInstance() {
    	return instance;
    }
   
    private CartDBBean() {}
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/BomBom");
        return ds.getConnection();
    }
    
    //[장바구니에 담기]를 클릭하면 수행되는 것으로 cart 테이블에 새로운 레코드를 추가
    public void insertCart(CartDataBean cart) 
    throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt2 = null;
        ResultSet rs = null;
        String sql="";
        
        try {
            conn = getConnection();
            
            int buy_count = 0;
            // 동일 상품이 장바구니에 담겨 있는지 체크
            sql = "select buyCount from cart where memberId = ? " +
                  "and proCode = ? ";
            pstmt2 = conn.prepareStatement(sql);
            pstmt2.setString(1, cart.getMemberId());
            pstmt2.setInt(2, cart.getProCode());
            rs = pstmt2.executeQuery();
            if (rs.next()) {
            	buy_count = rs.getByte(1);
            	buy_count += cart.getBuyCount();
            	
            	sql = "update cart set buyCount = ?,  totalPrice = ? "+ 
            		  "where proCode = ? and memberId = ? ";
	            pstmt = conn.prepareStatement(sql);
	            
	            pstmt.setInt(1, buy_count);
	            pstmt.setInt(2, buy_count*cart.getPrice());
	            pstmt.setInt(3, cart.getProCode());
	            pstmt.setString(4, cart.getMemberId());
	            
	            pstmt.executeUpdate();            	
 			} else {           
	            sql = "insert into cart (memberId, proCode," +
	            		"proName, Price, ProImg, buyCount, totalPrice) " +
	            		"values (?,?,?,?,?,?,?)";
	            pstmt = conn.prepareStatement(sql);
	            
	            pstmt.setString(1, cart.getMemberId());
	            pstmt.setInt(2, cart.getProCode());
	            pstmt.setString(3, cart.getProName());
	            pstmt.setInt(4, cart.getPrice());
	            pstmt.setString(5, cart.getProImg());
	            pstmt.setInt(6, cart.getBuyCount());
	            pstmt.setInt(7, cart.getTotalPrice());
	            
	            pstmt.executeUpdate();
 			}
        }catch(Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    //id에 해당하는 레코드의 수를 얻어내는 메소드
    public int getListCount(String id)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            		"select count(*) from cart where memberId=?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
               x= rs.getInt(1);
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

	 
     //id에 해당하는 레코드의 목록을 얻어내는 메소드
     public List<CartDataBean> getCart(String id) 
     throws Exception {
    	 Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         CartDataBean cart=null;
         String sql = "";
         List<CartDataBean> lists = null;
         
         try {
        	 conn = getConnection();
        	 
        	 sql = "SELECT * FROM cart WHERE memberId = ?";
             pstmt = conn.prepareStatement(sql);
             
             pstmt.setString(1, id);
             rs = pstmt.executeQuery();
             
             lists = new ArrayList<CartDataBean>();

            while (rs.next()) {
                cart = new CartDataBean();
                cart.setCartNum(rs.getInt("cartNum"));
                cart.setProCode(rs.getInt("proCode"));
                cart.setMemberId(rs.getString("memberId"));
                cart.setProName(rs.getString("proName"));
                cart.setPrice(rs.getInt("Price"));
                cart.setProImg(rs.getString("proImg")); 
                cart.setBuyCount(rs.getInt("buyCount"));
                cart.setTotalPrice(rs.getInt("totalPrice"));

                lists.add(cart);
			}
         }catch(Exception ex) {
             ex.printStackTrace();
         }finally {
             if (rs != null) 
            	 try { rs.close(); } catch(SQLException ex) {}
             if (pstmt != null) 
            	 try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) 
            	 try { conn.close(); } catch(SQLException ex) {}
         }
		 return lists;
     }

//     public List<CartDataBean> getCartBeforeBuy(String id) 
//     throws Exception {
//    	 Connection conn = null;
//         PreparedStatement pstmt = null;
//         ResultSet rs = null;
//         CartDataBean cart=null;
//         String sql = "";
//         List<CartDataBean> lists = null;
//         
//         try {
//        	 conn = getConnection();
//        	 
//        	 sql = "SELECT a.*, b.proStock from cart a, product b "
//         		 + "WHERE a.proCode = b.proCode "
//         		 + "  and a.memberId = ?";
//             pstmt = conn.prepareStatement(sql);
//             
//             pstmt.setString(1, id);
//             rs = pstmt.executeQuery();
//             
//             lists = new ArrayList<CartDataBean>();
//
//             while (rs.next()) {
//            	 // 재고 체크
//            	 System.out.println(">>> buy_count : " + rs.getByte("buy_count"));
//            	 System.out.println(">>> book_count : " + rs.getShort("book_count"));
//            	 int buy_count = Integer.parseInt(String.valueOf(rs.getByte("buy_count")));
//            	 int book_count = Integer.parseInt(String.valueOf(rs.getShort("book_count")));
//            	 System.out.println(">>> after buy_count : " + buy_count + ", book_count : " + book_count);
//            	 if (rs.getByte("buy_count") > rs.getShort("book_count")) {
//            		System.out.println(">>> ****************");
//            	 } else {
//	            	 cart = new CartDataBean();
//	            	 
//	            	 cart.setCartNum(rs.getInt("cartNum"));
//	            	 cart.setProCode(rs.getInt("proCode"));
//	            	 cart.setBook_title(rs.getString("book_title"));
//	            	 cart.setBuy_price(rs.getInt("buy_price"));
//	            	 cart.setBuy_count(rs.getByte("buy_count")); 
//	            	 cart.setBook_image(rs.getString("book_image"));
//	            	 
//	            	 lists.add(cart);
//            	 }
//			 }
//         }catch(Exception ex) {
//             ex.printStackTrace();
//         }finally {
//             if (rs != null) 
//            	 try { rs.close(); } catch(SQLException ex) {}
//             if (pstmt != null) 
//            	 try { pstmt.close(); } catch(SQLException ex) {}
//             if (conn != null) 
//            	 try { conn.close(); } catch(SQLException ex) {}
//         }
//		 return lists;
//     }
     
     //장바구니에서 수량을 수정시 실행되는 메소드
     public void updateCount(int cartNum, int count) 
     throws Exception {
    	 Connection conn = null;
         PreparedStatement pstmt = null;
       
         try {
        	 conn = getConnection();
            
             pstmt = conn.prepareStatement(
               "update cart set buyCount=? where cartNum=?");
             pstmt.setInt(1, count);
             pstmt.setInt(2, cartNum);
                        
             pstmt.executeUpdate();
         }catch(Exception ex) {
             ex.printStackTrace();
         }finally {
             if (pstmt != null) 
            	 try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) 
            	 try { conn.close(); } catch(SQLException ex) {}
         }
     }
     public void updateMoney(int cartNum, int price, int count) 
    	     throws Exception {
    	    	 Connection conn = null;
    	         PreparedStatement pstmt = null;
    	       
    	         try {
    	        	 conn = getConnection();
    	            
    	             pstmt = conn.prepareStatement(
    	               "update cart set totalPrice=? where cartNum=?");
    	             pstmt.setInt(1, count*price);
    	             pstmt.setInt(2, cartNum);
    	                        
    	             pstmt.executeUpdate();
    	         }catch(Exception ex) {
    	             ex.printStackTrace();
    	         }finally {
    	             if (pstmt != null) 
    	            	 try { pstmt.close(); } catch(SQLException ex) {}
    	             if (conn != null) 
    	            	 try { conn.close(); } catch(SQLException ex) {}
    	         }
    	     }
     //장바구니에서 cartNum에대한 레코드를 삭제하는 메소드
     public void deleteList(int cartNum) 
     throws Exception {
         Connection conn = null;
         PreparedStatement pstmt = null;
               
         try {
			 conn = getConnection();

             pstmt = conn.prepareStatement(
           	   "delete from cart where cartNum=?");
             pstmt.setInt(1, cartNum);
             
             pstmt.executeUpdate();
         }catch(Exception ex) {
             ex.printStackTrace();
         }finally {
             
             if (pstmt != null) 
            	 try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) 
            	 try { conn.close(); } catch(SQLException ex) {}
         }
     }
     
     //id에 해당하는 모든 레코드를 삭제하는 메소드로 [장바구니 비우기]단추를 클릭시 실행된다.
     public void deleteAll(String id)
     throws Exception {
         Connection conn = null;
         PreparedStatement pstmt = null;
                  
         try {
			 conn = getConnection();

             pstmt = conn.prepareStatement(
               "delete from cart where memberId=?");
             pstmt.setString(1, id);
             
             pstmt.executeUpdate();
         }catch(Exception ex) {
             ex.printStackTrace();
         }finally {
             if (pstmt != null) 
            	 try { pstmt.close(); } catch(SQLException ex) {}
             if (conn != null) 
            	 try { conn.close(); } catch(SQLException ex) {}
         }
     }

}