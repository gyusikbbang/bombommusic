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

public class ShopProductDBBean {
	
    private static ShopProductDBBean instance 
                            = new ShopProductDBBean();
    
    public static ShopProductDBBean getInstance() {
        return instance;
    }
    
    private ShopProductDBBean() {}
    
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
    
    //상품 등록 메소드
    public void insertProduct(ShopProductDataBean product) 
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            		"insert into product (proCate, proName, proLabel, Concerto, Price, proImg1, proImg2, proImg3, proInfo, proStock, recommend, regdate, buycount, discount_rate, audio) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            pstmt.setString(1, product.getProCate());
            pstmt.setString(2, product.getProName());
            pstmt.setString(3, product.getProLabel());
            pstmt.setBoolean(4, product.isConcerto());
            pstmt.setInt(5, product.getPrice());
            pstmt.setString(6, product.getProImg1());
            pstmt.setString(7, product.getProImg2());
            pstmt.setString(8, product.getProImg3());
            pstmt.setString(9, product.getProInfo());
            pstmt.setString(10, product.getProStock());
            pstmt.setInt(11, product.getRecommend());
            pstmt.setTimestamp(12, product.getRegdate());
            pstmt.setInt(13, product.getBuycount());
            pstmt.setInt(14, product.getDiscount_rate());
            pstmt.setString(15, product.getAudio());

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
	public int getProductCount()
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement("select count(*) from product");
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
	


	
	//분류별또는 전체등록된 상품의 정보를 얻어내는 메소드
	public List<ShopProductDataBean> getProducts(String proCate, int start, int end)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ShopProductDataBean> productList=null;
        
        try {
            conn = getConnection();
            
            String sql1 = "select * from product order by regdate asc limit ?,?";
            String sql2 = "select * from product ";
            sql2 += "where proCate = ? order by regdate asc limit ?,?";
           
            
            if(proCate.equals("all")){
                
            	pstmt = conn.prepareStatement(sql1);
                pstmt.setInt(1, start-1);
                pstmt.setInt(2, end);

            }else{
                pstmt = conn.prepareStatement(sql2);
                pstmt.setString(1, proCate);
                pstmt.setInt(2, start-1);
                pstmt.setInt(3, end);
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
                     product.setBuycount(rs.getInt("buycount"));
                     product.setProLabel(rs.getString("proLabel"));
                   
                     product.setProImg1(rs.getString("proImg1"));
                     product.setProImg2(rs.getString("proImg2"));
                     product.setProImg3(rs.getString("proImg3"));

             
                     product.setProInfo(rs.getString("proInfo"));
                     product.setProStock(rs.getString("proStock"));
                     product.setRecommend(rs.getInt("recommend"));
                     product.setRegdate(rs.getTimestamp("regdate"));
                     product.setConcerto(rs.getBoolean("concerto"));
                     product.setAudio(rs.getString("audio"));
                     
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
		                     product.setBuycount(rs.getInt("buycount"));
		                     product.setProLabel(rs.getString("proLabel"));
		                     
		                     product.setProImg1(rs.getString("proImg1"));
		                     product.setProImg2(rs.getString("proImg2"));
		                     product.setProImg3(rs.getString("proImg3"));

		             
		                     product.setProInfo(rs.getString("proInfo"));
		                     product.setProStock(rs.getString("proStock"));
		                     product.setRecommend(rs.getInt("recommend"));
		                     product.setRegdate(rs.getTimestamp("regdate"));
		                     product.setConcerto(rs.getBoolean("concerto"));
		                     product.setAudio(rs.getString("audio"));
		                     
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
	public ShopProductDataBean[] getProducts(String proCate,int count)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ShopProductDataBean productList[]=null;
        int i=0;
        
        try {
            conn = getConnection();
            
            String sql = "select * from product where proCate = ? ";
            sql += "order by regdate desc limit ?,?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, proCate);
            pstmt.setInt(2, 0);
            pstmt.setInt(3, count);
        	rs = pstmt.executeQuery();

            if (rs.next()) {
                productList = new ShopProductDataBean[count];
                do{
                     ShopProductDataBean product= new ShopProductDataBean();
                     product.setProCode(rs.getInt("proCode"));
                     product.setProCate(rs.getString("proCate"));
                     product.setProName(rs.getString("proName"));
                     product.setPrice(rs.getInt("Price"));
                     product.setBuycount(rs.getInt("buycount"));
                     product.setProLabel(rs.getString("proLabel"));
                     
                     product.setProImg1(rs.getString("proImg1"));
                     product.setProImg2(rs.getString("proImg2"));
                     product.setProImg3(rs.getString("proImg3"));

             
                     product.setProInfo(rs.getString("proInfo"));
                     product.setProStock(rs.getString("proStock"));
                     product.setRecommend(rs.getInt("recommend"));
                     product.setRegdate(rs.getTimestamp("regdate"));
                     product.setConcerto(rs.getBoolean("concerto"));
                     product.setAudio(rs.getString("audio"));
                     
                     productList[i]=product;
                     
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
		return productList;
    }
	
	// ProCode에 해당하는 음반의 정보를 얻어내는 메소드로 
    //등록된 음반을 수정하기 위해 수정폼으로 읽어들기이기 위한 메소드
	public ShopProductDataBean getProduct(int proCode)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ShopProductDataBean product=null;
        
        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            	"select * from product where proCode = ?");
            pstmt.setInt(1, proCode);
            
            rs = pstmt.executeQuery();

            if (rs.next()) {
                product = new ShopProductDataBean();
                
                product.setProCate(rs.getString("proCate"));
                product.setProName(rs.getString("proName"));
                product.setPrice(rs.getInt("Price"));
                product.setBuycount(rs.getInt("buycount"));
                product.setProLabel(rs.getString("proLabel"));
                product.setProImg1(rs.getString("proImg1"));
                product.setProImg2(rs.getString("proImg2"));
                product.setProImg3(rs.getString("proImg3"));
                product.setProInfo(rs.getString("proInfo"));
                product.setProStock(rs.getString("proStock"));
                product.setRecommend(rs.getInt("recommend"));
                product.setRegdate(rs.getTimestamp("regdate"));
                product.setConcerto(rs.getBoolean("concerto"));
                product.setAudio(rs.getString("audio"));
                product.setDiscount_rate(rs.getInt("discount_rate")); // hwna / 20230615
                
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
		return product;
    }
    
    // 등록된 상품의 정보를 수정시 사용하는 메소드
	public void updateProduct(ShopProductDataBean product, int proCode)
		    throws Exception {
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        String sql;

		        try {
		            conn = getConnection();

		            sql = "update product set proCate=?,ProName=?,Price=?, buycount=?, proLabel=?";
		            sql += ",proImg1=?,proImg2=?,proImg3=?,proInfo=?";
		            sql += ",proStock=?, recommend=?, regdate=?, Concerto=?, audio=?";
		            sql += " where proCode=?";

		            pstmt = conn.prepareStatement(sql);

		            pstmt.setString(1, product.getProCate());
		            pstmt.setString(2, product.getProName());
		            pstmt.setInt(3, product.getPrice());
		            pstmt.setInt(4, product.getBuycount());
		            pstmt.setString(5, product.getProLabel());

		            pstmt.setString(6, product.getProImg1());
		            pstmt.setString(7, product.getProImg2());
		            pstmt.setString(8, product.getProImg3());
		            pstmt.setString(9, product.getProInfo());
		            pstmt.setString(10, product.getProStock());
		            pstmt.setInt(11, product.getRecommend());
		            pstmt.setTimestamp(12, product.getRegdate());
		            pstmt.setBoolean(13, product.isConcerto());
		            pstmt.setString(14, product.getAudio());

		            pstmt.setInt(15, proCode);

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
    
    // proCode에  해당하는 음반의 정보를 삭제시 사용하는 메소드
    public void deleteProduct(int proCode)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        
        try {
			conn = getConnection();
			
			String query = "SET FOREIGN_KEY_CHECKS = 0";
            pstmt = conn.prepareStatement(query);
            pstmt.executeUpdate(query);
            
            pstmt = conn.prepareStatement(
            	"delete from product where proCode=?");
            pstmt.setInt(1, proCode);
            
            pstmt.executeUpdate();
            
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
    
    
    // 추천 해주는 매소드
    public int updater(int proCode, String ip) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		ResultSet rs = null;
		
		int x = 0;
		
		String spl2 = "";
		String spl3 = "";
		String spl4 = "";
		String spl5 = "";
		String dbsaveip = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(
					"select p.proCode,s.resaveip  From product p LEFT OUTER JOIN resaveip s ON p.proCode = s.proCode = 1 where p.proCode = ?  and s.resaveip = ? ");

			pstmt.setInt(1, proCode);
			pstmt.setString(2, ip);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				do {
					dbsaveip = rs.getString("s.resaveip");

				    if (dbsaveip.equals(ip)) {

						spl5 = " update product set recommend=recommend-1 where proCode = ? ";
						pstmt = conn.prepareStatement(spl5);
						pstmt.setInt(1, proCode);

						pstmt.executeUpdate();
						spl4 = " delete from resaveip where proCode= ? and resaveip = ? ";
						pstmt = conn.prepareStatement(spl4);
						pstmt.setInt(1, proCode);
						pstmt.setString(2, ip);

						pstmt.executeUpdate();
					x = 1; // 인증 성공

				     }
				} while (rs.next());

			} else{
						spl2 = " update product set recommend=recommend+1 where proCode = ? ";
						pstmt = conn.prepareStatement(spl2);
						pstmt.setInt(1, proCode);

						pstmt.executeUpdate();

						spl3 = " insert into resaveip values (?,?) ";
						pstmt = conn.prepareStatement(spl3);
						pstmt.setInt(1, proCode);
						pstmt.setString(2, ip);

						pstmt.executeUpdate();

						
						x = 0;
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


 //추천 판별하기 위한 메소드
	public int recommend(int proCode, String ip) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
	
		ResultSet rs = null;
		
		int x = 0;

		String spl2 = "";
		String spl3 = "";
		String dbsaveip = "";

		try {

			conn = getConnection();

			pstmt = conn.prepareStatement(
					"select p.proCode,s.resaveip  From product p LEFT OUTER JOIN resaveip s ON p.proCode = s.proCode = 1 where p.proCode = ?  and s.resaveip = ? ");

			pstmt.setInt(1, proCode);
			pstmt.setString(2, ip);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				do {
					dbsaveip = rs.getString("s.resaveip");

				    if (dbsaveip.equals(ip)) {
						
					x = 0; // 인증 성공

				     }
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
	
	public int mdPickInsert(int proCode) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;

        ResultSet rs = null;

        int x = 0;

        String spl2 = "";
        String spl3 = "";


        try {

            conn = getConnection();

            pstmt = conn.prepareStatement(
                    "select * from mdpick WHERE proCode = ? ");

            pstmt.setInt(1, proCode);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                do {



                        x = 0; // 이미 있는거


                } while (rs.next());

            } else {



                spl3 = "INSERT INTO mdpick SELECT *  FROM product p WHERE proCode = ?";


                pstmt = conn.prepareStatement(spl3);
                pstmt.setInt(1, proCode);
                pstmt.executeUpdate();



                x= 1; //없어서 인서트
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
	// 분류별, 판매량 , 추천수  랭킹 조회 메소드
	
	public List<ShopProductDataBean> getrankingProducts(String proCate, int start, int end, String select) throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<ShopProductDataBean> productList = null;

	    try {
	        conn = getConnection();

	        // 추천 순위
	        String sql1 = "SELECT *, recommend AS total FROM product ORDER BY recommend CAST(recommend AS SIGNED) DESC LIMIT ?,?";
	        String sql2 = "SELECT * FROM product WHERE proCate = ? ORDER BY recommend CAST(recommend AS SIGNED) DESC LIMIT ?,?";

	        // 구매량
	        String sql3 = "SELECT *, buycount AS total FROM product ORDER BY buycount DESC LIMIT ?,?";
	        String sql4 = "SELECT *, buycount AS total FROM product WHERE proCate = ? ORDER BY buycount DESC LIMIT ?,?";

	        // 구매 + 추천
	        String sql5 = "SELECT *, (buycount+recommend) AS total FROM product ORDER BY total DESC LIMIT ?,?";
	        String sql6 = "SELECT *, (buycount+recommend) AS total FROM product WHERE proCate = ? ORDER BY total DESC LIMIT ?,?";

	        if (select.equals("buyrecommend")) {
	            if (proCate.equals("all")) {
	                pstmt = conn.prepareStatement(sql5);
	                pstmt.setInt(1, start - 1);
	                pstmt.setInt(2, end);
	            } else {
	                pstmt = conn.prepareStatement(sql6);
	                pstmt.setString(1, proCate);
	                pstmt.setInt(2, start - 1);
	                pstmt.setInt(3, end);
	            }
	        } else if (select.equals("buycount")) {
	            if (proCate.equals("all")) {
	                pstmt = conn.prepareStatement(sql3);
	                pstmt.setInt(1, start - 1);
	                pstmt.setInt(2, end);
	            } else {
	                pstmt = conn.prepareStatement(sql4);
	                pstmt.setString(1, proCate);
	                pstmt.setInt(2, start - 1);
	                pstmt.setInt(3, end);
	            }
	        } else if (select.equals("recommend")) {
	            if (proCate.equals("all")) {
	                pstmt = conn.prepareStatement(sql1);
	                pstmt.setInt(1, start - 1);
	                pstmt.setInt(2, end);
	            } else {
	                pstmt = conn.prepareStatement(sql2);
	                pstmt.setString(1, proCate);
	                pstmt.setInt(2, start - 1);
	                pstmt.setInt(3, end);
	            }
	        }

	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            productList = new ArrayList<ShopProductDataBean>();
	            do {
	                ShopProductDataBean product = new ShopProductDataBean();

	                product.setProCode(rs.getInt("proCode"));
	                product.setProCate(rs.getString("proCate"));
	                product.setProName(rs.getString("proName"));
	                product.setPrice(rs.getInt("Price"));
	                product.setProLabel(rs.getString("proLabel"));
	                product.setProImg1(rs.getString("proImg1"));
	                product.setProImg2(rs.getString("proImg2"));
	                product.setProImg3(rs.getString("proImg3"));
	                product.setProInfo(rs.getString("proInfo"));
	                product.setProStock(rs.getString("proStock"));
	                product.setRecommend(rs.getInt("recommend"));
	                product.setBuycount(rs.getInt("buycount"));
	                product.setRegdate(rs.getTimestamp("regdate"));
	                product.setConcerto(rs.getBoolean("concerto"));
	                product.setSalerecommend(rs.getInt("total"));
	                product.setAudio(rs.getString("audio"));
	                product.setDiscount_rate(rs.getInt("discount_rate"));
	                productList.add(product);
	            } while (rs.next());
	        }
	    } catch (Exception ex) {
	        ex.printStackTrace();
	    } finally {
	        if (rs != null) {
	            try {
	                rs.close();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	        }
	        if (pstmt != null) {
	            try {
	                pstmt.close();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	        }
	        if (conn != null) {
	            try {
	                conn.close();
	            } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	        }
	    }
	    return productList;
	}

				
    
    
}