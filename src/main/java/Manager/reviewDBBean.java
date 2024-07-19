package Manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
    
//  관리자 인증 메소드
    public int managerCheck(String id, String passwd) 
	throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
        String dbpasswd="";
		int x=-1;
        
		try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select managerPasswd from manager where managerId = ? ");
            pstmt.setString(1, id);
            
            rs= pstmt.executeQuery();

			if(rs.next()){
				dbpasswd= rs.getString("managerPasswd"); 
				if(dbpasswd.equals(passwd))
					x= 1; //인증 성공
				else
					x= 0; //비밀번호 틀림
			}else
				x= -1;//해당 아이디 없음
			
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
	
  //리뷰 등록 메소드
    public void insertReivew(reviewDataBean review) 
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"insert into review values (?,?,?,?,?,?,?,?,?)");
            pstmt.setInt(1,review.getRvCode());
            pstmt.setInt(2, review.getProCode());
            pstmt.setString(3, review.getProName());
            pstmt.setString(4, review.getMemberId());
            pstmt.setString(5, review.getRvContent());
          
            pstmt.setString(6, review.getRvImg1());
            pstmt.setString(7, review.getRvImg2());
			pstmt.setString(8, review.getRvImg3());
			pstmt.setTimestamp(9, review.getRvRegdate());
			
            pstmt.executeUpdate();
            
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
    }
    
    
    public int reinsert(reviewDataBean review ,int proCode,String proName, String id,String content) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        ResultSet rs = null;

        int x = 0;

        String spl2 = "";
        String spl3 = "";
        String spl4 = "";
        String dbsaveip = "";

        try {

            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select memberId  from buy where memberId = ? and proCode = ?");
            pstmt.setString(1, id);
            pstmt.setInt(2, proCode);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                do {

                    spl3 = " insert into review (proCode,proName,rvContent,memberId,rvRegdate) values (?,?,?,?,?) ";
                    pstmt = conn.prepareStatement(spl3);
                    pstmt.setInt(1, proCode);
                    pstmt.setString(2, proName);
                    pstmt.setString(3, content);
                    pstmt.setString(4, id);
                    pstmt.setTimestamp(5, review.getRvRegdate());
                    pstmt.executeUpdate();
                    spl4 = " update shopping_member set bombompoint = bombompoint +100  where memberId = ?" ;
                    
                    pstmt = conn.prepareStatement(spl4);
                    pstmt.setString(1, id);
                    
               
                   
                    
                    pstmt.executeUpdate();
                    
                    
                    
                    
                    
                    

                    x = 0;
                } while (rs.next());

            } else{
                    x=1;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null)
                try {
                    rs.close();
                } catch (SQLException ex) {
                }
            if (pstmt != null)
                try {
                    pstmt.close();
                } catch (SQLException ex) {
                }
            if (conn != null)
                try {
                    conn.close();
                } catch (SQLException ex) {
                }
        }
        return x;
    }
    
    public int rvsearchCount (int proCode)
		    throws Exception {
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;
		        int x=0;
		        
		        try {
		            conn = getConnection();
		            
		            String sql1 = "SELECT count(*) FROM review WHERE proCode=? ";
		            
		                
		            pstmt = conn.prepareStatement(sql1);
		            pstmt.setInt(1, proCode);
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
    
    public int rvRegistCount (int proCode, String memberId)
		    throws Exception {
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;
		        int x=0;
		        
		        try {
		            conn = getConnection();
		            
		            String sql1 = "SELECT count(*) FROM review WHERE proCode=? AND memberId=?";
		            
		                
		            pstmt = conn.prepareStatement(sql1);
		            pstmt.setInt(1, proCode);
		            pstmt.setString(2, memberId);
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
 	public int getReviewCount()
     throws Exception {
         Connection conn = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;

         int x=0;

         try {
             conn = getConnection();
             
             pstmt = conn.prepareStatement("select count(*) from review");
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
    
 		//전체등록된 리뷰 정보를 얻어내는 메소드
 		public List<reviewDataBean> reviews(int proCode, int start, int end)
 	    throws Exception {
 	        Connection conn = null;
 	        PreparedStatement pstmt = null;
 	        ResultSet rs = null;
 	        List<reviewDataBean> reviewList=null;
 	        
 	        try {
 	            conn = getConnection();
 	            
 	            String sql1 = "select * from review where proCode=? order by rvRegdate asc limit ?,? ";
 	            
		 pstmt = conn.prepareStatement(sql1);
 	            		 pstmt.setInt(1, proCode);
 	            		pstmt.setInt(2, start-1);
	 	            	 pstmt.setInt(3, end);
 	            	 
 	            	
 	 
 	        	rs = pstmt.executeQuery();
 	            
 	            if (rs.next()) {
 	            	reviewList = new ArrayList<reviewDataBean>(end);
 	                do{
 	                	reviewDataBean review = new reviewDataBean();
 	                     
 	                	review.setRvCode(rs.getInt("rvCode"));
 	                	review.setProCode(rs.getInt("proCode"));
 	                	review.setProName(rs.getString("proName"));
 	                	
 	                	review.setMemberId(rs.getString("memberId"));
 	                	review.setRvContent(rs.getString("rvContent"));
 	                   
 	                	review.setRvImg1(rs.getString("rvImg1"));
 	                	review.setRvImg2(rs.getString("rvImg2"));
 	                	review.setRvImg3(rs.getString("rvImg3"));
 	                	review.setRvRegdate(rs.getTimestamp("rvRegdate"));
 	                     
 	                    reviewList.add(review);
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
 			return reviewList;
 	    }
 		
 		//마이페이지에서 리뷰 정보를 얻어내는 메소드
 		public List<reviewDataBean> myReviews(String memberId, int start, int end)
 	    throws Exception {
 	        Connection conn = null;
 	        PreparedStatement pstmt = null;
 	        ResultSet rs = null;
 	        List<reviewDataBean> reviewList=null;
 	        
 	        try {
 	            conn = getConnection();
 	            
 	            String sql1 = "select * from review where memberId=? order by rvRegdate asc limit ?,? ";
 	            
		 pstmt = conn.prepareStatement(sql1);
 	            		 pstmt.setString(1, memberId);
 	            		 pstmt.setInt(2, start-1);
	 	            	 pstmt.setInt(3, end);
 	            	 
 	            	
 	 
 	        	rs = pstmt.executeQuery();
 	            
 	            if (rs.next()) {
 	            	reviewList = new ArrayList<reviewDataBean>(end);
 	                do{
 	                	reviewDataBean review = new reviewDataBean();
 	                     
 	                	review.setRvCode(rs.getInt("rvCode"));
 	                	review.setProCode(rs.getInt("proCode"));
 	                	review.setProName(rs.getString("proName"));
 	                	review.setMemberId(rs.getString("memberId"));
 	                	review.setRvContent(rs.getString("rvContent"));
 	                   
 	                	review.setRvImg1(rs.getString("rvImg1"));
 	                	review.setRvImg2(rs.getString("rvImg2"));
 	                	review.setRvImg3(rs.getString("rvImg3"));
 	                	review.setRvRegdate(rs.getTimestamp("rvRegdate"));
 	                     
 	                    reviewList.add(review);
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
 			return reviewList;
 	    }
 		
 		//리뷰작성할때 상품이름 찾기
 		public String ReviewProName(int proCode) throws Exception {
 			Connection conn = null;
 			PreparedStatement pstmt = null;
 			ResultSet rs = null;
 			String name = "";

 			try {
 				conn = getConnection();

 				pstmt = conn.prepareStatement("select proName from review where proCode=?");
 				pstmt.setInt(1, proCode);
 				rs = pstmt.executeQuery();

 				if (rs.next()) {
 					name = rs.getString("proName");
 				}

 			} catch (Exception ex) {
 				ex.printStackTrace();
 			} finally {
 				if (rs != null)
 					try {
 						rs.close();
 					} catch (SQLException ex) {
 					}
 				if (pstmt != null)
 					try {
 						pstmt.close();
 					} catch (SQLException ex) {
 					}
 				if (conn != null)
 					try {
 						conn.close();
 					} catch (SQLException ex) {
 					}
 			}
 			return name;
 		}
 		
 		public int myRvsearchCount (String memberId)
 			    throws Exception {
 			        Connection conn = null;
 			        PreparedStatement pstmt = null;
 			        ResultSet rs = null;
 			        int x=0;
 			        
 			        try {
 			            conn = getConnection();
 			            
 			            String sql1 = "SELECT count(*) FROM review WHERE memberId=? ";
 			            
 			                
 			            pstmt = conn.prepareStatement(sql1);
 			            pstmt.setString(1, memberId);
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
 		
 		public int myRvRegistCount (String memberId)
 			    throws Exception {
 			        Connection conn = null;
 			        PreparedStatement pstmt = null;
 			        ResultSet rs = null;
 			        int x=0;
 			        
 			        try {
 			            conn = getConnection();
 			            
 			            String sql1 = "SELECT count(*) FROM review where memberId=?";
 			            
 			                
 			            pstmt = conn.prepareStatement(sql1);
 			            pstmt.setString(1, memberId);
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
 		
    
 		//이 밑으로 수정안함
 		public List<ShopProductDataBean> search (String proCate,String proName, int start, int end)
 			    throws Exception {
 			        Connection conn = null;
 			        PreparedStatement pstmt = null;
 			        ResultSet rs = null;
 			        List<ShopProductDataBean> productList=null;
 			        
 			        try {
 			            conn = getConnection();
 			            
 			            String sql1 = "SELECT * FROM product WHERE proName LIKE ? order by regdate asc limit ?,?";
 			            String sql2 = "select * from product ";
 			            sql2 += "where proCate = ? and proName LIKE ? order by regdate asc limit ?,? ";
 			            
 			            if(proCate.equals("all")){
 			                
 			            	 pstmt = conn.prepareStatement(sql1);
 			                 
 			                
 			                 pstmt.setString(1, "%" + proName + "%");
 			                 pstmt.setInt(2, start-1);
 			                 pstmt.setInt(3, end);
 			                 
 			            }else{
 			                pstmt = conn.prepareStatement(sql2);
 			                pstmt.setString(1, proCate);
 			                pstmt.setString(2, "%" + proName + "%");
 			                pstmt.setInt(3, start-1);
 			                pstmt.setInt(4, end);
 			            }
 			        	rs = pstmt.executeQuery();
 			            
 			            if (rs.next()) {
 			                productList = new ArrayList<ShopProductDataBean>();
 			                do{
 			                     ShopProductDataBean product= new ShopProductDataBean();
 			                     
 			                     product.setProCode(rs.getInt("proCode"));
 			                     product.setProCate(rs.getString("proCate"));
 			                     product.setProName(rs.getString("proName"));
 			                     product.setPrice(rs.getInt("Price"));
 			                   
 			                     product.setProImg1(rs.getString("proImg1"));
 			                     product.setProImg2(rs.getString("proImg2"));
 			                     product.setProImg3(rs.getString("proImg3"));

 			             
 			                     product.setProInfo(rs.getString("proInfo"));
 			                     product.setProStock(rs.getString("proStock"));
 			                     
 			                     product.setRegdate(rs.getTimestamp("regdate"));
 			                     
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



 	   
 		
 		// 쇼핑몰 메인에 표시하기 위해서 사용하는 분류별 상품목록을 얻어내는 메소드
 		public reviewDataBean[] getReviews(int proCode,int count)
 	    throws Exception {
 	        Connection conn = null;
 	        PreparedStatement pstmt = null;
 	        ResultSet rs = null;
 	        reviewDataBean reviewList[]=null;
 	        int i=0;
 	        
 	        try {
 	            conn = getConnection();
 	            
 	            String sql = "select * from review where proCode = ? ";
 	            sql += "order by rvRegdate desc limit ?,?";
 	            
 	            pstmt = conn.prepareStatement(sql);
 	            pstmt.setInt(1, proCode);
 	            pstmt.setInt(2, 0);
 	            pstmt.setInt(3, count);
 	        	rs = pstmt.executeQuery();

 	            if (rs.next()) {
 	            	reviewList = new reviewDataBean[count];
 	                do{
 	                	 reviewDataBean review= new reviewDataBean();
 	                	
		 	             review.setRvCode(rs.getInt("rvCode"));
		 	             review.setProCode(rs.getInt("proCode"));
		 	             review.setProName(rs.getString("proName"));
		 	             review.setMemberId(rs.getString("memberId"));
		 	             review.setRvContent(rs.getString("rvContent"));
		 	               
		 	             review.setRvImg1(rs.getString("rvImg1"));
		 	             review.setRvImg2(rs.getString("rvImg2"));
		 	             review.setRvImg3(rs.getString("rvImg3"));
 	              		 review.setRvRegdate(rs.getTimestamp("rvRegdate"));
 	                    
 	                    reviewList[i]=review;
 	                     
 	                     i++;
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
 			return reviewList;
 	    }
 		
 		// ProCode에 해당하는 음반의 정보를 얻어내는 메소드로 
 	    //등록된 음반을 수정하기 위해 수정폼으로 읽어들기이기 위한 메소드
 		public reviewDataBean getReview(int proCode)
 	    throws Exception {
 	        Connection conn = null;
 	        PreparedStatement pstmt = null;
 	        ResultSet rs = null;
 	        reviewDataBean review=null;
 	        
 	        try {
 	            conn = getConnection();
 	            
 	            pstmt = conn.prepareStatement(
 	            	"select * from review where proCode=? order by rvRegdate");
 	            pstmt.setInt(1, proCode);
 	            
 	            rs = pstmt.executeQuery();

 	            if (rs.next()) {
 	            	review = new reviewDataBean();
 	                
 	                review.setRvCode(rs.getInt("rvCode"));
                	review.setProCode(rs.getInt("proCode"));
                	review.setProName(rs.getString("proName"));
                	review.setMemberId(rs.getString("memberId"));
                	review.setRvContent(rs.getString("rvContent"));
                   
                	review.setRvImg1(rs.getString("rvImg1"));
                	review.setRvImg2(rs.getString("rvImg2"));
                	review.setRvImg3(rs.getString("rvImg3"));
                	review.setRvRegdate(rs.getTimestamp("rvRegdate"));
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
 			return review;
 	    }
 	    
 	    // 등록된 책의 정보를 수정시 사용하는 메소드
 		public int reviewModify(reviewDataBean review ,int proCode,String proName, String id,String content) throws Exception {
 	        Connection conn = null;
 	        PreparedStatement pstmt = null;

 	        ResultSet rs = null;

 	        String sql;
 	        int x = 0;

 	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
                    "select memberId from buy where memberId = ? and proCode = ?");
           		pstmt.setString(1, id);
            	pstmt.setInt(2, proCode);

				rs = pstmt.executeQuery();

				if (rs.next()) {
                do {
 	            
 	            
 	            sql = "update review set ProCode=?,proName=?";
 	            sql += ",memberId=?,rvContent=?";
 	            sql += ",rvRegdate=?";
 	            sql += " where proCode=? and memberId=?";
 	            
 	            pstmt = conn.prepareStatement(sql);
 	            
 	            pstmt.setInt(1, proCode);
 	            pstmt.setString(2, proName);
 	            pstmt.setString(3, id);	           
 	            pstmt.setString(4, content);
 				pstmt.setTimestamp(5, review.getRvRegdate());

 				pstmt.setInt(6, proCode);
 				pstmt.setString(7, id);
 	            
 	            pstmt.executeUpdate();
				x=0;
				} while (rs.next());

            } else{
                    x=1;
            }
 	            
 	        } catch(Exception ex) {
 	            ex.printStackTrace();
 	        } finally {
 	            if (pstmt != null) 
 	            	try { pstmt.close(); } catch(SQLException ex) {}
 	            if (conn != null) 
 	            	try { conn.close(); } catch(SQLException ex) {}
 	        }
			return x;
 	    }
 	    
 	    // proCode에  해당하는 음반의 정보를 삭제시 사용하는 메소드
 		public int reviewDelete(reviewDataBean review ,int proCode, String id) 
 				throws Exception {
 	        Connection conn = null;
 	        PreparedStatement pstmt = null;

 	        ResultSet rs = null;

 	        String sql;
 	        int x = 0;

 	        try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
                    "select memberId from buy where memberId = ? and proCode = ?");
           		pstmt.setString(1, id);
            	pstmt.setInt(2, proCode);

				rs = pstmt.executeQuery();

				if (rs.next()) {
                do {
 	            
 	            
 	            sql = "delete from review where proCode=? and memberId=?";
 	            
 	            pstmt = conn.prepareStatement(sql);
 	            
 	            pstmt.setInt(1, proCode);
 	            pstmt.setString(2, id);
 	            
 	            pstmt.executeUpdate();
				x=0;
				} while (rs.next());

            } else{
                    x=1;
            }
 	            
 	       } catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (pstmt != null) 
	            	try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) 
	            	try { conn.close(); } catch(SQLException ex) {}
	        }
			return x;
	    }
 	    
 	    public String ManagerName(String managerId) 
 				throws Exception {
 		Connection conn = null;
 		PreparedStatement pstmt = null;
 		ResultSet rs = null;
 		String name = "";
 		
 		
 		try{
 			conn = getConnection();
 			            
 			pstmt = conn.prepareStatement(
 			    "select managerName from manager where managerId = ?");
 			pstmt.setString(1, managerId);
 			rs= pstmt.executeQuery();

 			if(rs.next()){
 				name = rs.getString("managerName"); 
 			}
 				

 						
 		}catch(Exception ex) {
 			ex.printStackTrace();
 		}finally{
 			if (rs != null) 
 				try { rs.close(); } catch(SQLException ex) {}
 			if (pstmt != null) 
 				try { pstmt.close(); } catch(SQLException ex) {}
 			if (conn != null) 
 				try { conn.close(); } catch(SQLException ex) {}
 		}
 		return name;
 	}
 	    
 	    
 	    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}	
	
	
	
	
	
	
	
	
	
	
	
	

