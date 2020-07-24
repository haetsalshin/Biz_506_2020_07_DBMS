package com.biz.order.mapper;

import java.util.List;

import com.biz.order.model.OrderVO;

public interface OrderDao {
	// 테이블로 받아오는 데이터들을 각각을 OrderVO에 담고 이를 모두 List로 담는다.
	public List<OrderVO> selectAll();
	
	
	// Invalid bound statement ( not Found)
	//			com.biz.order.mapper.OrderDao.findBySeq
	// Dao에는 method가 있는데
	// 		Mapper는 같은 이름을 갖는 tag 속성을 찾을 수없다.
	
	
	// dao에 있으면 반드시 mapping xml에도 있어야 한다.
	public List<OrderVO> findByDateDistacne(String start_date, String end_date);
	public List<OrderVO> findByPCode (String pcode);
	public List<OrderVO> findByPName (String pname);
	// seq를 기준으로 한개의 값만 받아서 orderVO에 담는다.
	public OrderVO findBySeq(long seq);
	
	public int insert(OrderVO orderVO);
	public int update(OrderVO orderVO);
	public int delete(long seq);

}
