package com.sh.app.menu.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sh.app.menu.model.dto.Menu;

@Mapper
public interface MenuDao {

	List<Menu> findAll();

	List<Menu> findByType(String type);

	List<Menu> findByTypeTaste(String type, String taste);

}
