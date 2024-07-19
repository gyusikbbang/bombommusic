function openPop(){
		
		
    var pop_title = "상품 생성 완료" ;
    
    window.open("", pop_title) ;
    
    var frmData = document.frmData ;
    frmData.target = pop_title ;
    frmData.action = "../productProcess/product_Pro.jsp" ;
    
    frmData.submit() ;
    
    
    
}
