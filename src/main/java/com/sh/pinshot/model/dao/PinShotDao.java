package com.sh.pinshot.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.sh.pinshot.model.dto.PinUser;

@Mapper
public interface PinShotDao {

	@Insert("insert into pin_user values (to_char(seq_pin_user.nextval,'fm000'), #{name}, #{phone}, #{job}, #{email})")
	int saveUser(PinUser user);

	@Select("select * from pin_user order by name")
	List<PinUser> findAll();

	List<PinUser> userSearch(Map<String, Object> param);

	@Select("select * from pin_user where user_id = #{id}")
	PinUser findById(String id);

	int updateUser(Map<String, Object> param);

	@Delete("delete from pin_user where user_id = #{id}")
	int deleteUser(String id);

}
