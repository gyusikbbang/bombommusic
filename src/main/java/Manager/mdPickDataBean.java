package Manager;

import java.sql.Timestamp;

public class mdPickDataBean {
	private int proCode; // 상품 코드
	private String proCate;
	private String proName ; //상품 이름
	private String proLabel; // 레이블
	private int Price; //상품 가격
	private int salerecommend;
    private int buycount;
    private int discount_rate;
	private String proImg1; //상품 이미지1
	private String proImg2; //상품 이미지2
	private String proImg3; //상품 이미지3
	private String proInfo; // 상품 정보
	private String proStock; // 상품 재고
	private int recommend;
	private Timestamp regdate ; //상품 등록일자
	private boolean concerto; //협주곡여부	
	private String audio;
	
	public int getProCode() {
		return proCode;
	}
	public void setProCode(int proCode) {
		this.proCode = proCode;
	}
	public int getDiscount_rate() {
		return discount_rate;
	}
	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}
	public String getProCate() {
		return proCate;
	}
	public void setProCate(String proCate) {
		this.proCate = proCate;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public String getProLabel() {
		return proLabel;
	}
	public void setProLabel(String proLabel) {
		this.proLabel = proLabel;
	}
	public int getPrice() {
		return Price;
	}
	public void setPrice(int price) {
		Price = price;
	}
	public String getProImg1() {
		return proImg1;
	}
	public void setProImg1(String proImg1) {
		this.proImg1 = proImg1;
	}
	public String getProImg2() {
		return proImg2;
	}
	public void setProImg2(String proImg2) {
		this.proImg2 = proImg2;
	}
	public String getProImg3() {
		return proImg3;
	}
	public void setProImg3(String proImg3) {
		this.proImg3 = proImg3;
	}
	public String getProInfo() {
		return proInfo;
	}
	public void setProInfo(String proInfo) {
		this.proInfo = proInfo;
	}
	public String getProStock() {
		return proStock;
	}
	public void setProStock(String proStock) {
		this.proStock = proStock;
	}
	public int getRecommend() {
		return recommend;
	}
	public void setRecommend(int recommend) {
		this.recommend = recommend;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}

	public boolean isConcerto() {
		return concerto;
	}
	public void setConcerto(boolean concerto) {
		this.concerto = concerto;
	}
	public int getSalerecommend() {
		return salerecommend;
	}
	public void setSalerecommend(int salerecommend) {
		this.salerecommend = salerecommend;
	}
	public int getBuycount() {
		return buycount;
	}
	public void setBuycount(int buycount) {
		this.buycount = buycount;
	}
	public String getAudio() {
		return audio;
	}
	public void setAudio(String audio) {
		this.audio = audio;
	}
	

	

}