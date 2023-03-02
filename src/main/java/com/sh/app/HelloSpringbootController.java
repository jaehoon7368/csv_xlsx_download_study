package com.sh.app;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HelloSpringbootController {
	
	@GetMapping("/")
	public String home() {
		log.debug("인덱스페이지");
		return "forward:/index.jsp";
	}
	
	@GetMapping("/foo/foo")
	public String foo(Model model) {
		model.addAttribute("tel", "01012341234");
		return "foo/foo";
	}
}
