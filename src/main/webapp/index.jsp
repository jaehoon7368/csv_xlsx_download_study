<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="springboot" name="title"/>
</jsp:include>
<style>
    div.menu-test{width:50%; margin:0 auto; text-align:center;}
    div.result{width:70%; margin:0 auto;}
</style>
<%--
	GET /menu : 모든메뉴조회
	
	GET /menu/type/kr : 한식만 조회 
	GET /menu/type/ch : 중식만 조회
	GET /menu/type/jp : 일식만 조회
	
	GET /menu/taste/mild : 순한맛만 조회
	GET /menu/taste/hot : 매운맛만 조회
	
	GET /menu/10 : 10번 메뉴 조회(한건 조회)
	
	POST /menu : 메뉴한건 등록 (실제 데이터를 json형식)
	
	PUT /menu : 메뉴 한건 전체수정 
	PATCH /menu : 메뉴 한건 일부수정
	
	DELETE /menu/10 : 메뉴 한건 삭제
 --%>	
 <div id="menu-container" class="text-center">
        <!-- 1.GET /menu -->
        <div class="menu-test">
            <h4>전체메뉴조회(GET)</h4>
            <input type="button" class="btn btn-block btn-outline-success btn-send" id="btn-menu" value="전송" />
        </div>
        <div class="result" id="menu-result"></div>
        <script>
        document.querySelector("#btn-menu").addEventListener("click",(e)=>{
        	$.ajax({
        		url : "${pageContext.request.contextPath}/menu",
        		method : "GET",
        		success(data){
        			console.log(data); //js object (jquery가 json을 선변환후 전달)
        			renderMenuTable("#menu-result",data);
        		},
        		error : console.log
        	});
        });
        </script>
        
         <!-- 2.GET /menu/type/kr /menu/type/ch /menu/type/jp 타입별 조회 -->
        <div class="menu-test">
            <h4>메뉴 타입별 조회(GET)</h4>
            <select class="form-control" id="typeSelector">
                <option value="" disabled selected>음식타입선택</option>
                <option value="kr">한식</option>
                <option value="ch">중식</option>
                <option value="jp">일식</option>
            </select>
        </div>
        <div class="result" id="menuType-result"></div>
        <script>
        document.querySelector("#typeSelector").addEventListener('change',(e)=>{
        		console.log(e.target.value);
        		
        		$.ajax({
        			url : `${pageContext.request.contextPath}/menu/type/\${e.target.value}`,
        			method : "GET",
        			success(data){
        				console.log(data);
        				renderMenuTable("#menuType-result",data);
        			},
        			error : console.log
        		});
        });
        </script>
        
        <!-- GET /menu/type/kr/taste/mild -->
        <div class="menu-test">
	        <h4>메뉴 타입/맛별 조회(GET)</h4>
	        <form name="menuTypeTasteFrm">
	            <div class="form-check form-check-inline">
	                <input type="radio" class="form-check-input" name="type" id="get-no-type" value="all" checked>
	                <label for="get-no-type" class="form-check-label">모두</label>&nbsp;
	                <input type="radio" class="form-check-input" name="type" id="get-kr" value="kr">
	                <label for="get-kr" class="form-check-label">한식</label>&nbsp;
	                <input type="radio" class="form-check-input" name="type" id="get-ch" value="ch">
	                <label for="get-ch" class="form-check-label">중식</label>&nbsp;
	                <input type="radio" class="form-check-input" name="type" id="get-jp" value="jp">
	                <label for="get-jp" class="form-check-label">일식</label>&nbsp;
	            </div>
	            <br />
	            <div class="form-check form-check-inline">
	                <input type="radio" class="form-check-input" name="taste" id="get-no-taste" value="all" checked>
	                <label for="get-no-taste" class="form-check-label">모두</label>&nbsp;
	                <input type="radio" class="form-check-input" name="taste" id="get-hot" value="hot">
	                <label for="get-hot" class="form-check-label">매운맛</label>&nbsp;
	                <input type="radio" class="form-check-input" name="taste" id="get-mild" value="mild">
	                <label for="get-mild" class="form-check-label">순한맛</label>
	            </div>
	            <br />
	            <input type="submit" class="btn btn-block btn-outline-success btn-send" value="전송" >
	        </form>
	    </div>
	    <div class="result" id="menuTypeTaste-result"></div>
	    <script>
	    document.menuTypeTasteFrm.addEventListener('submit',(e)=>{
	    	e.preventDefault();
	    	const type = e.target.type.value;
	    	const taste = e.target.taste.value;
	    	
	    	$.ajax({
	    		url : `${pageContext.request.contextPath}/menu/type/\${type}/taste/\${taste}`,
	    		method : "GET",
	    		success(data){
    				console.log(data);
    				renderMenuTable("#menuTypeTaste-result",data);
    			},
    			error : console.log
	    	});
	    });
	    </script>
	</div>
<script>
/**
 * selector하위에 메뉴테이블을 생성
 * ------------------------------
 * 번호 음식점 메뉴명 가격 타입 맛 
 * ------------------------------
 *....
 *	<table class="table">...
 */
const renderMenuTable = (selector,data)=>{
	const container = document.querySelector(selector);
	
	let html = `
		<table class="table table-hover">
		<thead>
			<tr>
				<th scope='col'>번호</th>
				<th scope='col'>음식점</th>
				<th scope='col'>메뉴명</th>
				<th scope='col'>가격</th>
				<th scope='col'>타입</th>
				<th scope='col'>맛/th>
			</tr>
		</thead>
		<tbody>
	`;
	
	//반복처리
	if(data.length){
		data.forEach((menu) =>{
			const {id, restaurant,name,price,type,taste} = menu;
			html +=`
				<tr>
					<td>\${id}</td>
					<td>\${restaurant}</td>
					<td>\${name}</td>
					<td>₩\${price.toLocaleString()}</td>
					<td>\${type}</td>
					<td>\${taste}</td>
				</tr>
			`;
			
		});		
	}else{
		html +='<tr><td class="text-center" colspan="6">조회된 결과가 없습니다.</td></tr>';
	}
	
	html +=`
		</tbody>
	</table>
	`;
	container.innerHTML = html;
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>