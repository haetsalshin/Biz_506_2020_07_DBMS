package com.biz.dbms;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.biz.dbms.comain.OrderVO;
import com.biz.dbms.config.DBConnection;
import com.biz.dbms.config.DBContract;
import com.biz.dbms.config.Lines;
import com.biz.dbms.service.OrderService;
import com.biz.dbms.service.OrderServiceImplV1;
import com.biz.dbms.service.OrderView;

public class jdbcEx_02 {
	public static void main(String[] args) {
		
		// MVC2 모델
		// DB -> select ->     selectAll() -> List        ( main()출력 )
		// < 도메인영역 >         < Controller 영역 >      < view 영역 > 
		// < 모델 영역  >
		
		OrderService oService = new OrderServiceImplV1();
		OrderView oView = new OrderView();
		
		
		List<OrderVO> orderList = null;
		try {
			orderList = oService.selectAll();
			if(orderList == null || orderList.size() < 1) {
				System.out.println("데이터가 없습니다.");
				
			} else {
				oView.orderList(orderList);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}
}
