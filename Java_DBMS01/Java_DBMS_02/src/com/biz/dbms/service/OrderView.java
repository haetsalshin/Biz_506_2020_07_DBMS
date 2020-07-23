package com.biz.dbms.service;

import java.util.List;

import com.biz.dbms.comain.OrderVO;
import com.biz.dbms.config.Lines;

public class OrderView {
	
	// 매개변수로 받을 때가 필드변수로 받을 때보다 결합도가 가장 낮다.
	// 따라서 필드변수로 선언하는 것보다 더 사용 권장
	public void orderList(List<OrderVO> orderList) {
		
		System.out.println(Lines.dLine);
		System.out.println("주문내역서");
		System.out.println(Lines.dLine);
		System.out.println("SEQ\t주문번호\t주문일자\t고객\t상품\t수량\t가격\t합계");
		System.out.println(Lines.sLine);
		for(OrderVO vo : orderList) {
			System.out.printf("%5d\t",vo.getO_seq() );
			System.out.print(vo.getO_num() + "\t\t");
			System.out.print(vo.getO_date() + "\t");
			System.out.print(vo.getO_cnum() + "\t");
			System.out.print(vo.getO_pcode() + "\t");
			System.out.print(vo.getO_qty() + "\t");
			System.out.print(vo.getO_price() + "\t");
			System.out.print(vo.getO_total() + "\n");
		}
		
		System.out.println(Lines.dLine); 
		
	}// end order List
	
	
	public void orderDetailView(OrderVO orderVO) {
		
		System.out.println("================================");
		System.out.printf("주문번호:%s",orderVO.getO_num() +"\n");
		System.out.printf("고객번호:%s",orderVO.getO_cnum()+"\n");
		System.out.printf("상품코드:%s",orderVO.getO_pcode()+"\n");
		System.out.printf("가격:%s",orderVO.getO_price()+"\n");
		System.out.printf("수량:%s",orderVO.getO_qty()+"\n");
		System.out.println("================================");
		
		
	}
	

}
