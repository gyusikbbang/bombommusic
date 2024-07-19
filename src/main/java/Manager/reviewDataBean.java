package Manager;

import java.sql.Timestamp;

public class reviewDataBean {
	private int rvCode;
	private int proCode;
	private String proName;
	private String memberId;
	private String rvContent;
	private String rvImg1;
	private String rvImg2;
	private String rvImg3;
	private Timestamp rvRegdate;
	
	
	
	
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public int getRvCode() {
		return rvCode;
	}
	public void setRvCode(int rvCode) {
		this.rvCode = rvCode;
	}
	public int getProCode() {
		return proCode;
	}
	public void setProCode(int proCode) {
		this.proCode = proCode;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getRvContent() {
		return rvContent;
	}
	public void setRvContent(String rvContent) {
		this.rvContent = rvContent;
	}
	public String getRvImg1() {
		return rvImg1;
	}
	public void setRvImg1(String rvImg1) {
		this.rvImg1 = rvImg1;
	}
	public String getRvImg2() {
		return rvImg2;
	}
	public void setRvImg2(String rvImg2) {
		this.rvImg2 = rvImg2;
	}
	public String getRvImg3() {
		return rvImg3;
	}
	public void setRvImg3(String rvImg3) {
		this.rvImg3 = rvImg3;
	}
	public Timestamp getRvRegdate() {
		return rvRegdate;
	}
	public void setRvRegdate(Timestamp rvRegdate) {
		this.rvRegdate = rvRegdate;
	}
	
	
}

