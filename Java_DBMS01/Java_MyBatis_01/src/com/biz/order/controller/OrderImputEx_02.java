package com.biz.order.controller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.biz.order.config.DBConnection;
import com.biz.order.mapper.OrderDao;
import com.biz.order.model.OrderVO;
import com.biz.order.service.OrderInput;

public class OrderImputEx_02 {

	
	
	public static void main(String[] args) {
		SqlSession sqlSession = DBConnection.getSessionFactory().openSession(true);
		OrderDao orderDao = sqlSession.getMapper(OrderDao.class);

		
		List<OrderVO> orderList = orderDao.selectAll();
		
		System.out.println("===================================================================================================================================");
		System.out.println("SEQ\t\t날짜\t\t주문번호\t고객정보\t상품코드\t가격\t\t수량\t\t총액");
		System.out.println("===================================================================================================================================");
		for(OrderVO vo: orderList) {
			System.out.print(vo.getO_seq() + "\t\t");
			System.out.print(vo.getO_date() + "\t");
			System.out.print(vo.getO_num() + "\t\t");
			System.out.print(vo.getO_cnum() + "\t\t");
			System.out.print(vo.getO_pcode() + "\t\t");
			System.out.print(vo.getO_price() + "\t\t");
			System.out.print(vo.getO_qty() + "\t\t");
			System.out.print(vo.getO_total() + "\n");
			
		}
		System.out.println("===================================================================================================================================");
		
		OrderInput oInput = new OrderInput();
		while(true){
			
			if(!oInput.orderUpdate()) {
						
				break;
				
			}
		}

		System.out.println("업데이트 종료 !!!");
		
		
		
	}
	
	
	
	

}
