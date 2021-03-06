package com.biz.dbms.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.biz.dbms.comain.OrderVO;
import com.biz.dbms.config.DBConnection;
import com.biz.dbms.config.DBContract;
import com.biz.dbms.config.DBContract.ORDER;

public class OrderServiceImplV1 implements OrderService {
	
	DBContract.ORDER dbOrder; 
	
	
	// db를 연결할 Connection객체(이전에 만들어 놓은 getDBConnection이용
	protected Connection dbConn ;
	public OrderServiceImplV1() {
		// TODO Auto-generated constructor stub
		this.dbConn = DBConnection.getDBConnection();
	}
	
	
	/*
	 *  throws Exception
	 *  try-catch를 사용하여 자체적으로 exception을 Handling(처리)를 하였는데
	 *  try-catch가 코드내에 많아지면 코드의 가독성이 매우 떨어진다.
	 *  
	 *  exception 처리를 직접하지 않고
	 *  이 method를 호출한 곳에 대리 요청한다(exception을 던진다)
	 *  
	 */
	
	/*
	 *  insert를 호출하는 곳에서는 OrderVO 주문번호 데이터를 담고
	 *  매개변수로 전달해야 하며
	 *  try-catch로 exception 처리를 하고
	 *  결과 값으로 정수 값을 받아서 insert유무를 처리 해야 한다.
	 */
	
	@Override
	public int insert(OrderVO orderVO) throws SQLException {
		// TODO Auto-generated method stub
		
		String sql = DBContract.ORDER_INSERT;
		
		PreparedStatement pSt = this.dbConn.prepareStatement(sql);
		
		//VO를 통해서 전달받은 데이터를 SQL명령문과 합성하기
		pSt.setNString(1, orderVO.getO_num());
		pSt.setNString(2 , orderVO.getO_date());
		
		pSt.setNString(3, orderVO.getO_cnum());
		pSt.setNString(4, orderVO.getO_pcode());
		
		pSt.setInt(5, orderVO.getO_qty());
		pSt.setInt(6, orderVO.getO_price());
		
		int ret = pSt.executeUpdate();
		
		return ret;
	}

	/*
	 *  selectAll() method를 호출하는 곳에서는
	 *  아무런 매개변수 없이 method를 호출하고
	 *  exception 처리를 수행해야 하며
	 *  return 값을 List<OrderVO> 형 변수를 받아서 처리한다.
	 */
	@Override
	public List<OrderVO> selectAll() throws SQLException {
		
		List<OrderVO> orderList = new ArrayList<OrderVO>();
		String sql = DBContract.ORDER_SELECT_ALL;
		PreparedStatement pSt = dbConn.prepareStatement(sql);
		
		ResultSet rSet = pSt.executeQuery();
		
		while(rSet.next()) {
				
			OrderVO orderVO = this.setOrderVO(rSet);
			orderList.add(orderVO);
		}
		
		pSt.close();
		return orderList;
	}

	/*
	 *  selectAll()과 findBySeq() method에서
	 *  ResultSet으로 부터 데이터를 getter하여
	 *  OrderVO에 setter하는 부분을 별도 method로 분리하고
	 *  selectAll()과 findBySeq()에서 호출하여 사용할 수 있도록 구현
	 */
	
	// 해당 코드가 각기 다른 메서드에서 2번이상 호출되어 사용될 것 같으면
	// 메서드로 만들어서 처리한다.
	private OrderVO setOrderVO(ResultSet rSet) throws SQLException {
		OrderVO orderVO = new OrderVO();
		// 문자열.trim() : 문자열 앞과 뒤에 있는 공백을 제거하는 method
		
		orderVO.setO_seq( rSet.getLong(DBContract.ORDER.COL_O_SEQ_LONG.trim()) );
		
		orderVO.setO_date(rSet.getNString(DBContract.ORDER.COL_O_DATE_STR.trim()));
		
		orderVO.setO_num(rSet.getNString(DBContract.ORDER.COL_O_NUM_STR.trim()));
		
		orderVO.setO_cnum(rSet.getNString(DBContract.ORDER.COL_O_CNUM_STR.trim()));
		orderVO.setO_pcode(rSet.getNString(DBContract.ORDER.COL_O_PCODE_STR.trim()));
		
		orderVO.setO_price(rSet.getInt(DBContract.ORDER.COL_O_PRICE_INT.trim()));
		orderVO.setO_qty(rSet.getInt(DBContract.ORDER.COL_O_QTY_INT.trim()));
		
		orderVO.setO_total(orderVO.getO_price() * orderVO.getO_qty());
	
		return orderVO;
	}
	
	
	@Override
	public OrderVO findBySeq(long seq) throws SQLException {
		
		String sql = DBContract.ORDER_FIND_BY_SEQ;
		
		PreparedStatement pSt = dbConn.prepareStatement(sql);
		
		pSt.setLong(1, seq);
		
		// rSet에 담기게 될 table데이터는 
		// 단1개의 데이터만 담기거나, 없는 상태가 된다.
		// list가 아니라 VO 가 된다.
		// 그래서 while문을 쓸 필요가 없다.
		ResultSet rSet = pSt.executeQuery();
		if(rSet.next()) { // 내가 읽을 데이터만 보여줘라
		
			OrderVO orderVO = this.setOrderVO(rSet);
			return orderVO;
		}
		return null;
	}

	@Override
	public int update(OrderVO orderVO) throws SQLException {
		
		String sql = DBContract.ORDER_UPDATE;
		PreparedStatement pSt =  dbConn.prepareStatement(sql);
		
		pSt.setString(1, orderVO.getO_num());	
		pSt.setString(2,orderVO.getO_date());	
		pSt.setString(3,orderVO.getO_cnum());	
		pSt.setString(4,orderVO.getO_pcode());	
		pSt.setInt(5,orderVO.getO_price());	
		pSt.setInt(6,orderVO.getO_qty());	
		pSt.setLong(7,orderVO.getO_seq());	
		
		int ret = pSt.executeUpdate();
		return ret;
	}

	@Override
	public int delete(long seq) throws SQLException {
		
		String sql = DBContract.ORDER_DELETE;
		PreparedStatement pSt = dbConn.prepareStatement(sql);
		pSt.setLong(1,seq);
		int ret = pSt.executeUpdate();
		return ret;
		
		
	}

}
