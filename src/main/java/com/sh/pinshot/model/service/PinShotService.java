package com.sh.pinshot.model.service;

import java.util.List;
import java.util.Map;

import com.sh.pinshot.model.dto.PinUser;

public interface PinShotService {

	int saveUser(PinUser user);

	List<PinUser> findAll();

	List<PinUser> userSearch(Map<String, Object> param);

	PinUser findById(String id);

	int updateUser(Map<String, Object> param);

	int deleteUser(String id);

}
