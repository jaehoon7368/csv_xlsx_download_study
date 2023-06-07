package com.sh.pinshot;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class IndexController {
	
	@GetMapping("/")
	public String home() {
		log.debug("인덱스페이지");
		return "forward:/index.jsp";
	}
	
}
