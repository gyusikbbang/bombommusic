package Buy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Cart.CartDataBean;
import Manager.ShopProductDataBean;

public class BuyDBBean {
private static BuyDBBean instance = new BuyDBBean();
	
	public static BuyDBBean getInstance() {
    	return instance;
    }
   
    private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/BomBom");
        return ds.getConnection();
    }

    // 회원명 가져오는 함수
    public String getMemberName(String memberId) {
        String memberName = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = getConnection();
            // member 테이블에서 해당 회원의 이름을 가져오는 SQL 쿼리
            String query = "SELECT memberName FROM shopping_member WHERE memberId = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();

            // 결과가 존재하면, 회원명을 얻어온다.
            if (rs.next()) {
                memberName = rs.getString("memberName");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 리소스 반환
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return memberName;
    }
    
    public void purchase(List<CartDataBean> cartList) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = getConnection();

            for (CartDataBean cart : cartList) {
                // buy 테이블에 데이터를 INSERT하는 SQL 쿼리
                String query = "INSERT INTO buy (memberId, memberName, proCode, proName, Price, buyCount, proImg, regdate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, cart.getMemberId());
                pstmt.setString(2, "예시 이름"); // 참고: CartDataBean에 memberName이 없으므로 예시 이름을 대신 사용했습니다.
                pstmt.setInt(3, cart.getProCode());
                pstmt.setString(4, cart.getProName());
                pstmt.setInt(5, cart.getPrice());
                pstmt.setInt(6, cart.getBuyCount());
                pstmt.setString(7, cart.getProImg());
                pstmt.setTimestamp(8, new java.sql.Timestamp(System.currentTimeMillis())); // 참고: CartDataBean에 buy_date가 없으므로 현재 시간을 사용했습니다.

                // 쿼리 실행
                pstmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 리소스 반환
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    //주어진 회원의 주문 목록을 가져오는 함수
    public List<BuyDataBean> getBuyList(String memberId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<BuyDataBean> buyList = null;
        
        try {
            conn = getConnection();
            String sql = "SELECT * FROM buy WHERE memberId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();

            buyList = new ArrayList<BuyDataBean>();
            
            while (rs.next()) {
            	
                BuyDataBean buy = new BuyDataBean();
                buy.setMemberId(rs.getString("memberId"));
                buy.setMemberName(rs.getString("memberName"));
                buy.setProCode(rs.getInt("proCode"));
                buy.setProName(rs.getString("proName"));
                buy.setPrice(rs.getInt("Price"));
                buy.setBuyCount(rs.getInt("buyCount"));
                buy.setProImg(rs.getString("proImg"));
                buy.setBuy_date(rs.getDate("regdate"));
                buyList.add(buy);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
            if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        }
        
        return buyList;
    }
    
  //id에 해당하는 레코드의 수를 얻어내는 메소드
    public int getBuyCount(String id)
    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        int x=0;

        try {
            conn = getConnection();
            
            pstmt = conn.prepareStatement(
            		"select count(*) from buy where memberId=?");
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
    
    // 결제 (장비구니에 있는 것을 구매할 경우)
    public int purchase(String memberId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt2 = null;
        int result = 0;
        try {
            conn = getConnection();

            // buy 테이블에 데이터를 INSERT하는 SQL 쿼리
            String query = "INSERT INTO buy (memberId, memberName, proCode, proName, Price, buyCount, proImg, regdate) "
		        		+ "SELECT a.memberId, b.memberName, a.proCode, a.proName, a.Price, a.buyCount, a.proImg, date_format(now(), '%Y-%m-%d') "
		        		+ "  FROM cart a, shopping_member b "
		        		+ " WHERE a.memberId = b.memberId "
		        		+ "   AND a.memberId = ?";
            
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, memberId);

            // 쿼리 실행
            result = pstmt.executeUpdate();
            
            System.out.println(">>>> result : " + result);
            
            // 장바구니 비우기
            if (result > 0) {
            	query = "DELETE FROM cart WHERE memberId = ? ";
            
	            pstmt2 = conn.prepareStatement(query);
	            pstmt2.setString(1, memberId); 
	            
	            System.out.println(">>>> pstmt2 : " + pstmt2.toString());
	            
	            // 쿼리 실행
	            result = pstmt2.executeUpdate();	            
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 리소스 반환
            if (pstmt2 != null) {
                try {
                    pstmt2.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }        	
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return result;
    }
    
    // 결제 (바로 구매)
    public int purchase(BuyDataBean buyDataBean) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = getConnection();

            // buy 테이블에 데이터를 INSERT하는 SQL 쿼리
            String query = "INSERT INTO buy (memberId, memberName, proCode, proName, Price, buyCount, proImg, regdate) "
		        		+ "SELECT a.memberId, a.memberName, ?, ?, ?, ?, ?, date_format(now(), '%Y-%m-%d') "
		        		+ "  FROM shopping_member a "
		        		+ " WHERE a.memberId = ?";
            
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, buyDataBean.getProCode());
            pstmt.setString(2, buyDataBean.getProName());
            pstmt.setInt(3, buyDataBean.getPrice());
            pstmt.setInt(4, buyDataBean.getBuyCount());
            pstmt.setString(5, buyDataBean.getProImg());
            pstmt.setString(6, buyDataBean.getMemberId());

            // 쿼리 실행
            result = pstmt.executeUpdate();
           
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 리소스 반환
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return result;
    }    
    
     // 매니져 주문목록
    public List<BuyDataBean> getBuyList(int start, int end) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<BuyDataBean> buyList = null;
        
        try {
            conn = getConnection();
            String sql = "SELECT * FROM buy ORDER BY regdate asc LIMIT ?,?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, start-1);
            pstmt.setInt(2, end);
            
            rs = pstmt.executeQuery();

            buyList = new ArrayList<BuyDataBean>();
            
            while (rs.next()) {
            	
                BuyDataBean buy = new BuyDataBean();
                buy.setMemberId(rs.getString("memberId"));
                buy.setMemberName(rs.getString("memberName"));
                buy.setProCode(rs.getInt("proCode"));
                buy.setProName(rs.getString("proName"));
                buy.setPrice(rs.getInt("Price"));
                buy.setBuyCount(rs.getInt("buyCount"));
                buy.setProImg(rs.getString("proImg"));
                buy.setBuy_date(rs.getDate("regdate"));
                buyList.add(buy);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) {}
            if (conn != null) try { conn.close(); } catch (SQLException ex) {}
        }
        
        return buyList;
    }
    
    //
    public int getBuyCount()
    	    throws Exception {
    	        Connection conn = null;
    	        PreparedStatement pstmt = null;
    	        ResultSet rs = null;

    	        int x=0;

    	        try {
    	            conn = getConnection();
    	            
    	            pstmt = conn.prepareStatement(
    	            		"select count(*) from buy;");
    	          
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
    	   
    
    
    public int searchcount(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int x = 0;

		try {
			conn = getConnection();

			String sql1 = "SELECT count(*) FROM buy WHERE MemberId LIKE ? ";
		

			

				pstmt = conn.prepareStatement(sql1);

				pstmt.setString(1, "%" + memberId + "%");

			
			rs = pstmt.executeQuery();

			if (rs.next()) {

				do {
					x = rs.getInt(1);
				} while (rs.next());
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
    
    
    
    public List<BuyDataBean> search(String memberId, int start, int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BuyDataBean> buylist = null;

		try {
			conn = getConnection();

			String sql1 = "SELECT * FROM buy WHERE memberId LIKE ? order by regdate asc limit ?,?";
			

			
			     pstmt = conn.prepareStatement(sql1);
				pstmt.setString(1, "%" + memberId + "%");
				pstmt.setInt(2, start - 1);
				pstmt.setInt(3, end);

			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				buylist = new ArrayList<BuyDataBean>();
				do {
					BuyDataBean buy = new BuyDataBean();

					 buy.setMemberId(rs.getString("memberId"));
		                buy.setMemberName(rs.getString("memberName"));
		                buy.setProCode(rs.getInt("proCode"));
		                buy.setProName(rs.getString("proName"));
		                buy.setPrice(rs.getInt("Price"));
		                buy.setBuyCount(rs.getInt("buyCount"));
		                buy.setProImg(rs.getString("proImg"));
		                buy.setBuy_date(rs.getDate("regdate"));

		                buylist.add(buy);
				} while (rs.next());
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
		return buylist;
	}
    
    public String proAudio(String proCode) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String audio = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select audio from product where proCode = ?");
			pstmt.setString(1, proCode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				audio = rs.getString("audio");
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
		return audio;
	}
    
    
    
}