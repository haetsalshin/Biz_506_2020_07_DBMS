package com.biz.order.controller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.biz.order.config.DBConnect;
import com.biz.order.dao.OrderDao;
import com.biz.order.model.OrderVO;

public class OrderEx_01 {
	
	public static void main(String[] args) {
		
		// 세션을 열어라
		SqlSession sqlSession = DBConnect.getSqlSesseionFactory().openSession(true);
		
		// 세션에게 mapper라는 것을 주고 orderDao에 담음
		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);
		
		// orderDao.selectAll() method를 호출했더니 그 값이 orderList에 담김
		List<OrderVO> orderList = orderDao.selectAll();
		
		System.out.println("==============================================");
		System.out.println("주문리스트");
		System.out.println("==============================================");
		for(OrderVO vo : orderList) {
			System.out.print(vo.getO_num() + "\t");
			System.out.print(vo.getO_cnum()+ "\t");
			System.out.print(vo.getO_pcode()+ "\t");
			System.out.print(vo.getO_price()+ "\t");
			System.out.print(vo.getO_qty()+ "\t");
			System.out.println(vo.getO_price() * vo.getO_qty());
		}
		
	}
	
	
	

}
