package com.sh.app.menu.model.service;

import java.util.List;

import com.sh.app.menu.model.dto.Menu;

public interface MenuService {

	List<Menu> findAll();

	List<Menu> findByType(String type);

	List<Menu> findByTypeTaste(String type, String taste);

	Menu findById(long id);

	int insertMenu(Menu menu);

	int updateMenu(Menu menu);

	int deleteMenu(long id);

}
