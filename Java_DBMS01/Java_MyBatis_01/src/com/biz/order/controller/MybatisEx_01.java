package com.biz.order.controller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.biz.order.config.DBConnection;
import com.biz.order.mapper.OrderDao;
import com.biz.order.model.OrderVO;

public class MybatisEx_01 {
	
	public static void main(String[] args) {
		
		// sqlSession야 내가 지금부터 DBMS와 연결하려고 하니 통로를 하나 만들어주렴
		//		: 송류관. 데이터연결 통로
		SqlSession sqlSession = DBConnection.getSessionFactory().openSession(true);
		
		// 클래스가 없기 때문에 new로 생성하지 못한다.
		// 내가 지금 orderdao라는 interface를 만들었으니
		// 그 인터페이스를 mapper랑 잘 버물러서 클래스를 하나 만들고
		// 그 클래스를 만들어서 orderDao라는 객체로 만들어라.
		/*
		 * 쌤 ) OrderDao interface와 mapper.xml 파일을 참조하여 생성한 
		 * OrderDaoImpl(가칭) 클래스를 만들고
		 * 그 클래스로 객체를 생성하여 
		 * 나에게 달라.(getMapper)
		 * 그리고 그 객체를 OrderDao에 담아서 쓸 수 있도록 해 달라.
		 */
		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);
		
		List<OrderVO> orderList = orderDao.selectAll();
		
		for(OrderVO vo: orderList) {
			System.out.println(vo);
			
		}
		
		
	}

}
