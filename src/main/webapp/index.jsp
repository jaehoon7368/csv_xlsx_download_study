<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="springboot" name="title"/>
</jsp:include>
<style>
    div.pinshot{width:50%; margin:0 auto; text-align:center;}
    div.result{width:70%; margin:0 auto;}
</style>

 <div id="menu-container" class="text-center">
 
  <div class="pinshot">
  <br />
  <br />
	        <h4>1. 직원 정보 등록</h4>
	        <form name="userEnrollFrm">
	            <input type="text" name="name" placeholder="이름" class="form-control" required/>
	            <br />
	            <input type="text" name="phone" placeholder="전화번호" class="form-control" required/>
	            <br />
	            <div class="form-check form-check-inline">
	                <input type="radio" class="form-check-input" name="job" id="j1" value="부장" checked>
	                <label for="j1" class="form-check-label">부장</label>&nbsp;
	                <input type="radio" class="form-check-input" name="job" id="j2" value="과장">
	                <label for="j2" class="form-check-label">과장</label>&nbsp;
	                <input type="radio" class="form-check-input" name="job" id="j3" value="대리">
	                <label for="j3" class="form-check-label">대리</label>&nbsp;
	                <input type="radio" class="form-check-input" name="job" id="j4" value="사원">
	                <label for="j4" class="form-check-label">사원</label>&nbsp;
	            </div>
	            <input type="text" name="email" placeholder="이메일" class="form-control" required/>
	            <br />
	            <input type="submit" class="btn btn-block btn-outline-success btn-send" value="등록" >
	        </form>
	    </div>
	    <script>
	    document.userEnrollFrm.addEventListener('submit',(e)=>{
	    	e.preventDefault();
	    	
	    	const name = e.target.name.value;
	    	const phone = e.target.phone.value;
	    	const job = e.target.job.value;
	    	const email = e.target.email.value;
	    	  
	    	const phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;
	    	const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	    	  
	    	if (!phoneRegex.test(phone)) {
	    	  alert('유효한 전화번호를 입력해주세요.');
	    	  return;
	    	 }
	    	  
	    	if (!emailRegex.test(email)) {
	    	  alert('유효한 이메일 주소를 입력해주세요.');
	    	  return;
	    	 }
	    	  
	    	const user = {
	    	   name,
	    	   phone,
	    	   job,
	    	   email
	    	 };
	    	 console.log(user);
	    	
	    	
	    	$.ajax({
	    		url : '${pageContext.request.contextPath}/save.do',
	    		data: JSON.stringify(user),
	    		method : "POST",
	    		contentType : "application/json; charset=utf-8", 
	    		success(data){
	    			console.log(data);
	    		},
	    		error : console.log,
	    		complete(){
	    			e.target.reset();
	    		}
	    	});
	    });
	    </script>

		<br />
		<br />
		<br />
        <div class="pinshot">
            <h4>2. 직원 리스트 출력</h4>
            <input type="button" class="btn btn-block btn-outline-success btn-send" id="btn-user" value="조회" />
        </div>
        <div class="result" id="users-result"></div>
        <script>
        document.querySelector("#btn-user").addEventListener("click",(e)=>{
        	$.ajax({
        		url : "${pageContext.request.contextPath}/users.do",
        		method : "GET",
        		success(data){
        			console.log(data);
        			renderUserTable("#users-result",data);
        		},
        		error : console.log
        	});
        });
        </script>
      
      <br />
      <br />
      <div class="pinshot">
		<h4>3. 직원검색</h4>
		
		<div>
	        <form name="userSearchFrm">
	            <select name="searchType" required>
	                <option value="">검색타입</option>
	                <!-- required여부를 판단할 value="" 반드시 있어야함.-->
	                <option value="user_id">직원번호</option>                
	                <option value="name">이름</option>
	                <option value="job">직급</option>
	                <option value="phone">전화번호</option>
	                <option value="email">이메일</option>
	            </select>
	            <input type="search" name="searchKeyword" required/>    
	            <input type="submit" value="검색" />
	        </form>
	    </div>
	    <div class="result" id="search-result"></div>
<script>
	    document.userSearchFrm.addEventListener('submit',(e)=>{
	    	e.preventDefault();
	    	
	    	const searchType = e.target.searchType.value;
	    	const searchKeyword = e.target.searchKeyword.value;
	    	
	    	console.log(searchType, searchKeyword);
			
	    	$.ajax({
	    		url : '${pageContext.request.contextPath}/search.do',
	    		data : {searchType, searchKeyword},
	    		success(data){
	    			console.log(data);
	    			renderUserTable("#search-result",data);
	    		},
	    		error : console.log
	    	});
	    });
</script>

		<br />
		<br />
		<div>
			<h4>4. 직원 정보 수정</h4>
			<form id="searchFrm" name="searchFrm">
				<input type="text" name="userId" placeholder="직원번호" class="form-control" /><br />
				<input type="submit" class="btn btn-block btn-outline-primary btn-send" value="검색" >
			</form>
		
			<hr />
			<form id="userUpdateFrm" name="userUpdateFrm">
				<p>직원번호</p>
				<input type="text" name="userId" placeholder="직원번호" class="form-control"/>
				<br />
				<p>이름</p>
				<input type="text" name="name" placeholder="이름" class="form-control" />
				<br />
				<p>전화번호</p>
				<input type="text" name="phone" placeholder="전화번호" class="form-control" />
				<br />
				<p>직급</p>
				<div class="form-check form-check-inline">
	                <input type="radio" class="form-check-input" name="job" id="j1" value="부장" checked>
	                <label for="j1" class="form-check-label">부장</label>&nbsp;
	                <input type="radio" class="form-check-input" name="job" id="j2" value="과장">
	                <label for="j2" class="form-check-label">과장</label>&nbsp;
	                <input type="radio" class="form-check-input" name="job" id="j3" value="대리">
	                <label for="j3" class="form-check-label">대리</label>&nbsp;
	                <input type="radio" class="form-check-input" name="job" id="j4" value="사원">
	                <label for="j4" class="form-check-label">사원</label>&nbsp;
	            </div>
	            <br />
	            <p>이메일</p>
				<input type="text" name="email" placeholder="이메일" class="form-control" required/>
	            <br />
				<input type="submit" class="btn btn-block btn-outline-success btn-send" value="수정" >
			</form>
		</div>

<script>
	
document.searchFrm.addEventListener('submit',(e)=>{
	const id = document.querySelector("[name=userId]").value;
	e.preventDefault();
	findById(id);
});

document.userUpdateFrm.addEventListener('submit',(e)=>{
	e.preventDefault();
	
	const id = document.querySelector("[name=userId]").value;
	const userId = e.target.userId.value;
	const name = e.target.name.value;
	const phone = e.target.phone.value;
	const job = e.target.job.value;
	const email = e.target.email.value;
	  
	const phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;
	const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	  
	if (!phoneRegex.test(phone)) {
	  alert('유효한 전화번호를 입력해주세요.');
	  return;
	 }
	  
	if (!emailRegex.test(email)) {
	  alert('유효한 이메일 주소를 입력해주세요.');
	  return;
	 }
	  
	const user = {
		userId,
	    name,
	    phone,
	    job,
	    email
	 };
	 console.log(user);
	
	
	$.ajax({
		url : `${pageContext.request.contextPath}/update/\${id}`,
		data: JSON.stringify(user),
		method : "PUT",
		contentType : "application/json; charset=utf-8", 
		success(data){
			console.log(data);
		},
		error : console.log,
		complete(){
			e.target.reset();
		}
	});
	
});
</script>
		
		<br />
		<br />
		<div class="pinshot">
	        <h4>5. 직원 정보 삭제</h4>
	        <form id="deleteFrm" name="deleteFrm">
	            <input type="text" name="id" placeholder="직원번호" class="form-control" /><br />
	            <input type="submit" class="btn btn-block btn-outline-danger btn-send" value="삭제" >
	        </form>
	    </div>
	    <script>
	    document.deleteFrm.addEventListener('submit',(e)=>{
	    	e.preventDefault();
	    		
	    	$.ajax({
	    		url : `${pageContext.request.contextPath}/\${e.target.id.value}`,
	    		method : "DELETE",
	    		success(data){
	    			console.log(data); 
	    		},
	    		error : console.log
	    	})	
	    });
	    </script>
        	    
</div> 

	<br />
	<br />
	<button onclick="location.href = '${pageContext.request.contextPath}/download'">csv 다운로드</button>
	<br />
	<button onclick="location.href = '${pageContext.request.contextPath}/download/xlsx'">xlsx 다운로드</button>
<script>
const findById = (id) =>{
	console.log(id);
	
	$.ajax({
		url : `${pageContext.request.contextPath}/user/\${id}`,
		method : "GET",
		success(data){
			console.log(data);
			const frm = document.userUpdateFrm;
			const {userId,name,phone,job,email} = data;
			frm.userId.value = userId;
			frm.name.value = name;
			frm.phone.value = phone;
			frm.job.value = job;
			frm.email.value = email;
		},
		error : console.log
	});
};

const renderUserTable = (selector,data)=>{
	const container = document.querySelector(selector);
	
	let html = `
		<table class="table table-hover">
		<thead>
			<tr>
				<th scope='col'>직원번호</th>
				<th scope='col'>직급</th>
				<th scope='col'>이름</th>
				<th scope='col'>전화번호</th>
				<th scope='col'>이메일</th>
			</tr>
		</thead>
		<tbody>
	`;
	
	//반복처리
	if(data.length){
		data.forEach((user) =>{
			const {userId,name,phone,job,email} = user;
			html +=`
				<tr data-id="\${userId}">
					<td><a href="javascript:findById('\${userId}')">\${userId}</a></td>
					<td>\${job}</td>
					<td>\${name}</td>
					<td>\${phone}</td>
					<td>\${email}</td>
				</tr>
			`;
			
		});		
	}else{
		html +='<tr><td class="text-center" colspan="5">조회된 결과가 없습니다.</td></tr>';
	}
	
	html +=`
		</tbody>
	</table>
	`;
	container.innerHTML = html;
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>