package com.biz.order.dao;

import java.util.List;

import com.biz.order.model.OrderVO;

public interface OrderDao {

	// 인터페이스만 달랑~
	// 인터페이스만 주면 mybatis가 selectall이 해야할 일을 다 해준다.
	public List<OrderVO> selectAll();
	
	
	
}
