package com.sh.app.menu.controller;

import java.net.URI;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sh.app.menu.model.dto.Menu;
import com.sh.app.menu.model.service.MenuService;

import lombok.extern.slf4j.Slf4j;

@RestController //모든 핸들러에 @ResponseBody 적용
@RequestMapping("/menu")
@Slf4j
//@CrossOrigin
public class MenuController {
	
	@Autowired
	private MenuService menuService;
	
//	@CrossOrigin // 응답헤더에 추가 Access-Controller-Allow-Origin : *
	@GetMapping
	public List<Menu> menu(){
		return menuService.findAll();
	}
	
	/**
	 * /menu/type/kr
	 * /menu/type/ch
	 * /menu/type/jp
	 */
	@GetMapping("/type/{type}")
	public List<Menu> findByType(@PathVariable String type){
		log.debug("type = {}",type);
		return menuService.findByType(type);
	}
	
	@GetMapping("/type/{type}/taste/{taste}")
	public List<Menu> findByTypeTaste(@PathVariable String type, @PathVariable String taste){
		log.debug("type = {}",type);
		log.debug("taste = {}",taste);
		
		return menuService.findByTypeTaste(type,taste);
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Menu> findById(@PathVariable long id) {
		log.debug("id = {}",id);
		Menu menu = menuService.findById(id);
		if(menu == null) {
			return ResponseEntity.notFound().build(); // 404
		}
		// 정상적으로 조회된 경우
//		return ResponseEntity.ok().body(menu);
		return ResponseEntity.ok(menu);
	}
	
	@PostMapping
	public ResponseEntity<?> insertMenu(@RequestBody Menu menu,HttpServletRequest request){
		log.debug("menu = {}",menu);
		int result = menuService.insertMenu(menu);
		return ResponseEntity.created(URI.create(request.getContextPath()+"/menu/" + menu.getId())).build();
	}
	
	@PutMapping
	public ResponseEntity<?> updateMenu(@RequestBody Menu menu){
		log.debug("menu = {}",menu);
		// 수정
		int result = menuService.updateMenu(menu);
		// 갱신된 정보 재조회
		Menu updateMenu = menuService.findById(menu.getId());
		return ResponseEntity.ok(updateMenu);
	}
	
	/**
	 * 200(OK)
	 * 204(No Content) - 삭제작업 성공후 해당데이터가 더이상 존재하지 않음.
	 * @param id
	 * @return
	 */
	@DeleteMapping("/{id}")
	public ResponseEntity<?> deleteMenu(@PathVariable long id){
		//삭제
		int result = menuService.deleteMenu(id);
		return ResponseEntity.noContent().build(); //204
	}
}
