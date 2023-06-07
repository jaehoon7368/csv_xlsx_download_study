package com.sh.pinshot.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.pinshot.model.dao.PinShotDao;
import com.sh.pinshot.model.dto.PinUser;

@Service
public class PinShotServiceImpl implements PinShotService {
	
	@Autowired
	private PinShotDao pinshotDao;
	
	@Override
	public int saveUser(PinUser user) {
		return pinshotDao.saveUser(user);
	}
	
	@Override
	public List<PinUser> findAll() {
		return pinshotDao.findAll();
	}
	
	@Override
	public List<PinUser> userSearch(Map<String, Object> param) {
		return pinshotDao.userSearch(param);
	}
	
	@Override
	public PinUser findById(String id) {
		return pinshotDao.findById(id);
	}
	
	@Override
	public int updateUser(Map<String, Object> param) {
		return pinshotDao.updateUser(param);
	}
	
	@Override
	public int deleteUser(String id) {
		return pinshotDao.deleteUser(id);
	}

}
