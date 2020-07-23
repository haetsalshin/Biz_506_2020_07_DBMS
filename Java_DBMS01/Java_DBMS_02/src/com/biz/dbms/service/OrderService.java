package com.biz.dbms.service;

import java.sql.SQLException;
import java.util.List;

import com.biz.dbms.comain.OrderVO;

public interface OrderService {
	
	// Java에서 DBMS와 관련된 App을 만들 때 최소한으로 구현해야 할 method
	public int insert(OrderVO orderVO) throws SQLException; // orderVO에 값을 담아서 전달받아 insert 추가 수행
	
	public List<OrderVO> selectAll() throws SQLException; // 조건에 관계없이 모든 데이터를 추출하여 return
	public OrderVO findBySeq( long seq) throws SQLException; // findById(), PK칼럼을 기준으로 데이터 SELECT
	
	public int update(OrderVO orderVO) throws SQLException; // return값이 1이거나 그보다 크므로 int로 해준다.
	public int delete(long seq) throws SQLException; 
	
	/*
	 * insert와 update는 매개변수로 VO를 보내고
	 * 
	 * 누군가로부터 PK값을 전달받아야 SELECT를 할 수 있으므로 long seq(PK)값을 매개변수로 전달받아서
	 * 나머지 값들을(OrderVO 매개변수를) return값으로 보내라.
	 * 
	 * 위와 같은 형태로 만드는 것을 디자인 패턴이라고 한다.
	 */
	
	
	

}
