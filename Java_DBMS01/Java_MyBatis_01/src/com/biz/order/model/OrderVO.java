package com.biz.order.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 * VO(DTO)클래스 선언
 * DBMS(MyBatis)와 연동하는 프로젝트에서 VO클래스의 필드변수는
 * 연동하는 table의 칼럼 이름과 같게 한다.
 * 변수 패턴은 snack_case
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OrderVO {
	
	private long o_seq; // oSeq 로 해주면 DBMS에서는 OSEQP로 인식한다. 
						// 따라서 O_SEQ로 될 수 있도록 이렇게 변수명 지정해준다. 
	private String o_date;
	private String o_num;
	private String o_cnum;
	private String o_pcode;
	private String o_pname;
	
	private int o_price;
	private int o_qty;
	private int o_total;

}
