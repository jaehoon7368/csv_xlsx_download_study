package com.sh.pinshot.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.sh.pinshot.model.dto.PinUser;
import com.sh.pinshot.model.service.PinShotService;


@RestController
public class PinShotController {

	@Autowired
	private PinShotService pinshotService;
	
	@PostMapping("/save.do") //직원 정보 등록
	public ResponseEntity<?> saveUser(@RequestBody PinUser user){
		
		System.out.println("user = " + user);
		
		
		int res = pinshotService.saveUser(user);
		
		Map<String,Object> result = new HashMap<>();
		if(res > 0) {
			result.put("결과", "성공");
		}else {
			result.put("결과", "실패");
		}
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(result);
	}
	
	@GetMapping("/users.do") // 직원 리스트 출력
	public ResponseEntity<?> findAll(){
		
		List<PinUser> userList = pinshotService.findAll();
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(userList);
	}
	
	@GetMapping("/search.do") // 직원검색
	public ResponseEntity<?> userSearch(String searchType, String searchKeyword){
		
		System.out.println("type = " + searchType);
		System.out.println("keyword = " + searchKeyword);
		
		Map<String, Object> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		
		List<PinUser> userList = pinshotService.userSearch(param);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(userList);
	}
	
	@GetMapping("user/{id}") //수정하기 전 정보 불러오기
	public ResponseEntity<?> findById(@PathVariable String id){
		
		System.out.println("id = " + id);
		
		PinUser user = pinshotService.findById(id);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(user);
	}
	
	@PutMapping("/update/{id}") // 직원 정보 수정
	public ResponseEntity<?> updateUser(@RequestBody PinUser user, @PathVariable String id){
		System.out.println("user = " + user);
		System.out.println("id = " + id);
		
		Map<String, Object> param = new HashMap<>();
		param.put("userId", user.getUserId());
		param.put("name", user.getName());
		param.put("phone", user.getPhone());
		param.put("job", user.getJob());
		param.put("email", user.getEmail());
		param.put("id", id);
			
		int res = pinshotService.updateUser(param);
		
		Map<String,Object> result = new HashMap<>();
		if(res > 0) {
			result.put("결과", "성공");
		}else {
			result.put("결과", "실패");
		}
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(result);
	}
	
	@DeleteMapping("/{id}") // 직원 정보 삭제
	public ResponseEntity<?> deleteUser(@PathVariable String id){
		System.out.println("id = " + id);
		
		int res = pinshotService.deleteUser(id);
		
		Map<String,Object> result = new HashMap<>();
		if(res > 0) {
			result.put("결과", "성공");
		}else {
			result.put("결과", "실패");
		}
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON.toString())
				.body(result);
	}
	
	@GetMapping("/download") //csv 파일 다운로드
	public ResponseEntity<?> download(){
		System.out.println("다운로드");
		
		List<PinUser> userList = pinshotService.findAll();
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/csv; charset=MS949");
		header.add("Content-Disposition", "attachment; filename=\"" + "user.csv" + "\"");
		
		return new ResponseEntity<String>(setContent(userList),header,HttpStatus.CREATED);
	}
	
	public String setContent(List<PinUser> user) {
		String data = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		
		data += "직원번호, 이름, 전화번호, 직급, 이메일, 데이터기준일 : " + sdf.format(new Date()) + "\n";
		
		for(int i = 0; i < user.size(); i++) {
			data += user.get(i).getUserId() + ",";
			data += user.get(i).getName() + ",";
			data += user.get(i).getPhone() + "," ;
			data += user.get(i).getJob() + "," ;
			data += user.get(i).getEmail() + "\n" ;
		}
		
		return data;
	}
	
	@GetMapping("/download/xlsx") // xlsx 파일 다운로드
	public void downloadXls(HttpServletResponse response) throws IOException {
		Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("첫번째 시트");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("직원번호");
        cell = row.createCell(1);
        cell.setCellValue("이름");
        cell = row.createCell(2);
        cell.setCellValue("전화번호");
        cell = row.createCell(3);
        cell.setCellValue("직급");
        cell = row.createCell(4);
        cell.setCellValue("이메일");
        
        List<PinUser> user = pinshotService.findAll();
        
        for(int i = 0; i < user.size(); i++) {
        	row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(user.get(i).getUserId());
            cell = row.createCell(1);
            cell.setCellValue(user.get(i).getName());
            cell = row.createCell(2);
            cell.setCellValue(user.get(i).getPhone());
            cell = row.createCell(3);
            cell.setCellValue(user.get(i).getJob());
            cell = row.createCell(4);
            cell.setCellValue(user.get(i).getEmail());
        }
        
        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment; filename=user.xlsx");
        
        wb.write(response.getOutputStream());
        wb.close();
        
	}
}
