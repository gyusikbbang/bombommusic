package LoginDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Base64;
import java.util.Base64.Decoder;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import Manager.ShopProductDataBean;

public class LoginDBBean {

	private static LoginDBBean instance = new LoginDBBean();

	public static LoginDBBean getInstance() {
		return instance;
	}

	private LoginDBBean() {
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/BomBom");
		return ds.getConnection();
	}

	public int getmemberCount()
		    throws Exception {
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;

		        int x=0;

		        try {
		            conn = getConnection();
		            
		            pstmt = conn.prepareStatement("select count(*) from shopping_member");
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
	
	
	
	public int insertMember(LoginDataBean member, String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		String dbpasswd = "";
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select memberId from shopping_member where memberId= ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = 0; 
			} else {
					pstmt = conn.prepareStatement("insert into shopping_member values (?,?,?,?,?,?,?,?,?)");
					pstmt.setString(1, member.getMemberId());
					pstmt.setString(2, member.getMemberPw());
					pstmt.setString(3, member.getMemberName());
					pstmt.setString(4, member.getMemberPhone());
					pstmt.setString(5, member.getMemberEmail());
					pstmt.setString(6, member.getMemberAddr());
					pstmt.setInt(7, member.getLoginNum());
				
					pstmt.setTimestamp(8, member.getMember_reg());
					pstmt.setInt(9,member.getBombompoint());
					pstmt.executeUpdate();
					x = -1;// 해당 아이디 없음

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

	

	public int userCheck(String memberId, String memberPw) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select memberPw from shopping_member where memberId= ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("memberPw");
				if (dbpasswd.equals(memberPw)) {
					x = 1; // 인증 성공
				   
                
                
				}
				else
					x = 0; // 비밀번호 틀림
			} else
				x = -1;// 해당 아이디 없음

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

	public int kakaocheck(String memberId, String memberPw) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbPw = "";
		int result = -1;
	
		try {
			conn = getConnection();
	
			pstmt = conn.prepareStatement("SELECT memberPw FROM shopping_member WHERE memberId = ?");
			
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				dbPw = rs.getString("memberPw");
				dbPw = new String(Base64.getDecoder().decode(dbPw));
				if (dbPw.equals(memberPw))
					result = 1; // 인증 성공
				else
					result = 0; // 비밀번호 틀림
			} else
				result = -1; // 해당 아이디 없음
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) {
				try { rs.close(); } catch(SQLException ex) {}
			}
			if (pstmt != null) {
				try { pstmt.close(); } catch(SQLException ex) {}
			}
			if (conn != null) {
				try { conn.close(); } catch(SQLException ex) {}
			}
		}
	
		return result;
	}

	public int usertype(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int login_num = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select loginnum from shopping_member where memberId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				login_num = rs.getInt("loginnum");
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
		return login_num;
	}

	public String userName(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String name = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select memberName from shopping_member where memberId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				name = rs.getString("memberName");
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
	
	public String userPoint(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String point = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select bombompoint from shopping_member where memberId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				point = rs.getString("bombompoint");
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
		return point;
	}
	
	
	public String userEmail(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Email = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select memberEmail from shopping_member where memberId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Email = rs.getString("memberEmail");
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
		return Email;
	}
	
	public String userPhone(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Phone = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select memberPhone from shopping_member where memberId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Phone = rs.getString("memberPhone");
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
		return Phone;
	}
	
	public String userPw(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Pw = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select memberPw from shopping_member where memberId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Pw = rs.getString("memberPw");
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
		return Pw;
	}
	
	public String userAddr(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Addr = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select memberAddr from shopping_member where memberId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				Addr = rs.getString("memberAddr");
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
		return Addr;
	}
	
	public void updateMember(LoginDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update shopping_member set memberPw=?, "
					+ "memberName=?, memberPhone=?, memberEmail = ?, memberAddr = ? where memberId=?" );

			pstmt.setString(1, member.getMemberPw());
			pstmt.setString(2, member.getMemberName());
			pstmt.setString(3, member.getMemberPhone());
			pstmt.setString(4, member.getMemberEmail());
			pstmt.setString(5, member.getMemberAddr());
			pstmt.setString(6, member.getMemberId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
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
	}
	
	
	
	public List<LoginDataBean> gettypemember(String loginNum, int start, int end)
		    throws Exception {
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;
		        List<LoginDataBean> memberList=null;
		        
		        try {
		            conn = getConnection();
		            
		            String sql1 = "SELECT m.memberId,m.memberName,m.memberPhone,m.memberEmail,m.memberAddr,m.member_reg,l.login_type FROM shopping_member m INNER JOIN usertype l ON m.loginNum = l.login_num  order by m.member_reg asc limit ?,?";
		            String sql2 = "SELECT m.memberId,m.memberName,m.memberPhone,m.memberEmail,m.memberAddr,m.member_reg,l.login_type FROM shopping_member m INNER JOIN usertype l ON m.loginNum = l.login_num ";
		            sql2 += "where m.loginNum = ? order by m.member_reg asc limit ?,?";
		            
		            if(loginNum.equals("all")){
		                
		            	 pstmt = conn.prepareStatement(sql1);
		                 pstmt.setInt(1, start-1);
		                 pstmt.setInt(2, end);
		                 
		            }else{
		                pstmt = conn.prepareStatement(sql2);
		                pstmt.setString(1, loginNum);
		                pstmt.setInt(2, start-1);
		                pstmt.setInt(3, end);
		            }
		        	rs = pstmt.executeQuery();
		            
		            if (rs.next()) {
		            	memberList = new ArrayList<LoginDataBean>();
		                do{
		                	LoginDataBean member= new LoginDataBean();
		                     
		                     member.setMemberId(rs.getString("memberId"));
		                     member.setMemberName(rs.getString("memberName"));
		                     member.setMemberPhone(rs.getString("memberPhone"));
		                     member.setMemberEmail(rs.getString("memberEmail"));
		                     member.setMemberAddr(rs.getString("memberAddr"));
		                  
		                     member.setMember_reg(rs.getTimestamp("member_reg"));
		                     member.setLogin_type(rs.getString("login_type"));
		                     memberList.add(member);
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
				return memberList;
		    }
	
	// 마이페이지 에서 활용
	public LoginDataBean getMypage(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LoginDataBean mypage = new LoginDataBean();
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from shopping_member where memberId = ?");
			 
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				mypage.setMemberId(rs.getString("memberId"));
				mypage.setMemberName(rs.getString("memberName"));
				mypage.setMemberPhone(rs.getString("memberPhone"));
				mypage.setMemberEmail(rs.getString("memberEmail"));
				mypage.setMemberAddr(rs.getString("memberAddr"));
             
				mypage.setMember_reg(rs.getTimestamp("member_reg"));
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
		return mypage;
	}
	public void updateMember(LoginDataBean member, String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;

		try {
			conn = getConnection();

			sql = "update shopping_member set memberPw=?, memberName=?, memberPhone=?, memberEmail=?, memberAddr=? where memberId=? ";
			

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, member.getMemberPw());
			pstmt.setString(2, member.getMemberName());
			pstmt.setString(3, member.getMemberPhone());
			pstmt.setString(4, member.getMemberEmail());
			pstmt.setString(5, member.getMemberAddr());
			pstmt.setString(6, memberId);

			pstmt.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
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
	}
	public void deleteMember(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("delete from shopping_member where memberId=?");
			pstmt.setString(1, memberId);

			pstmt.executeUpdate();

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
	}
	
	public List<LoginDataBean> getTypeMember(String loginNum, int start, int end)
		    throws Exception {
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;
		        List<LoginDataBean> memberList=null;
		        
		        try {
		            conn = getConnection();
		            
		            String sql1 = "SELECT m.memberId,m.memberName,m.memberPhone,m.memberEmail,m.memberAddr,m.member_reg,l.typename , m.loginNum FROM shopping_member m INNER JOIN usertype l ON m.loginNum = l.loginnum  order by m.member_reg asc limit ?,?";
		            String sql2 = "SELECT m.memberId,m.memberName,m.memberPhone,m.memberEmail,m.memberAddr,m.member_reg,l.typename , m.loginNum FROM shopping_member m INNER JOIN usertype l ON m.loginNum = l.loginnum ";
		            sql2 += "where m.loginNum = ? order by m.member_reg asc limit ?,?";
		            
		            if(loginNum.equals("all")){
		                
		            	 pstmt = conn.prepareStatement(sql1);
		                 pstmt.setInt(1, start-1);
		                 pstmt.setInt(2, end);
		                 
		            }else{
		                pstmt = conn.prepareStatement(sql2);
		                pstmt.setString(1, loginNum);
		                pstmt.setInt(2, start-1);
		                pstmt.setInt(3, end);
		            }
		        	rs = pstmt.executeQuery();
		            
		            if (rs.next()) {
		            	memberList = new ArrayList<LoginDataBean>();
		                do{
		                	LoginDataBean member= new LoginDataBean();
		                     
		                     member.setMemberId(rs.getString("memberId"));
		                     member.setMemberName(rs.getString("memberName"));
		                     member.setMemberPhone(rs.getString("memberPhone"));
		                     member.setMemberEmail(rs.getString("memberEmail"));
		                     member.setMemberAddr(rs.getString("memberAddr"));
		                  
		                     member.setMember_reg(rs.getTimestamp("member_reg"));
		                     member.setLoginNum(rs.getInt("loginNum"));
		                     member.setTypename(rs.getString("typename"));
		                     memberList.add(member);
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
				return memberList;
		    }
	
	public LoginDataBean getMember(String memberId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LoginDataBean member = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from shopping_member where memberId = ?");
			pstmt.setString(1, memberId);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new LoginDataBean();
				member.setMemberId((rs.getString("memberId")));
				member.setMemberName((rs.getString("memberName")));
				member.setMemberPw((rs.getString("memberPw")));
				member.setMemberPhone((rs.getString("memberPhone")));
				member.setMemberEmail((rs.getString("memberEmail")));
				member.setMemberAddr((rs.getString("memberAddr")));
				member.setLoginNum((rs.getInt("loginNum")));
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
		return member;
	}
}