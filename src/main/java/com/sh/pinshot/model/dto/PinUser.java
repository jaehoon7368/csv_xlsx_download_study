package com.sh.pinshot.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PinUser {
	
	private String userId;
	private String name;
	private String phone;
	private String job;
	private String email;

}
