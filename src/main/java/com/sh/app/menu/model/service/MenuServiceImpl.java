package com.sh.app.menu.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sh.app.menu.model.dao.MenuDao;
import com.sh.app.menu.model.dto.Menu;

@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuDao menuDao;
	
	@Override
	public List<Menu> findAll() {
		return menuDao.findAll();
	}
	
	@Override
	public List<Menu> findByType(String type) {
		return menuDao.findByType(type);
	}
	
	@Override
	public List<Menu> findByTypeTaste(String type, String taste) {
		return menuDao.findByTypeTaste(type,taste);
	}
	
	@Override
	public Menu findById(long id) {
		return menuDao.findById(id);
	}
	
	@Override
	public int insertMenu(Menu menu) {
		return menuDao.insertMenu(menu);
	}
	
	@Override
	public int updateMenu(Menu menu) {
		return menuDao.updateMenu(menu);
	}
	
	@Override
	public int deleteMenu(long id) {
		return menuDao.deleteMenu(id);
	}
}
