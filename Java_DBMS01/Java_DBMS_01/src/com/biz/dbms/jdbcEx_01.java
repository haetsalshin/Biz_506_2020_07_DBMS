package com.biz.dbms;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.biz.dbms.comain.OrderVO;
import com.biz.dbms.config.DBContract;
import com.biz.dbms.config.DBContract.ORDER;

public class jdbcEx_01 {
	
	public static void main(String[] args) {
		
		
		List<OrderVO> orderList = new ArrayList<OrderVO>();
		
		
		try {
			/*
			 *  쌤)Java에서 JDBC를 통하여 OracleDriver 클래스와 연결하고
			 *  Java 코드에서 보내는 SQL Query를 Oracle DBMS에게 전달을 할텐데
			 *  
			 *  그 때 JDBC에서 연결한 오라클 연결 도우미 미들웨어(OracleDriver.class)를
			 *  
			 *  사용가능한 형태로 만들어주는 Java 한 기능을 수행하는데
			 *  그 때 사용하는 JDK가 Class.forName()이라는 method이다.
			 *  	Class.forName()
			 *  
			 *  OracleDriver.class를 사용할 준비를 한다.
			 *  
			 *  클래스 객체 = new 클래스()라고 만들텐데,
			 *  
			 *  OracleDriver.class는 태생이 Java전용 클래스와 달라서 
			 *  사용하기 위해서 초기화를 한 방법이 일반 클래스와 다르다.
			 *  
			 *  Class.forName() method 도움을 받아서 사용할 준비를 수행하는 것
			 *  
			 */
			// Class : oracle 드라이버를 자바에서 쓸 수 있게 준비해주는 클래스
			Class.forName(DBContract.DB_DRIVER);
			
			// 오라클에 연결하기
			// 1. Connection 설치
			Connection dbConn = null;
			
			// 2. Connection에게 오라클에 접속하라 라고 지시
			// 3. 접속이 완료되면 접속관련된 정보를 dbConn객체에 저장하라
			dbConn = DriverManager.getConnection(
					DBContract.DB_URL,
					DBContract.DB_USER,
					DBContract.DB_PASSWORD);
			System.out.println("DB Connection OK!!!");
			
			// 4. DB에게 SQL 보내기
			PreparedStatement pSt = null;
			String strSql = DBContract.ORDER_SELECT;
			// System.out.println(strSql);
			
			// DB에게 SQL을 보내고 
			// 그 결과를 pSt(PreparedStatement)에 받아라
			// 		OracleDriver를 통해서 SQL문을 보낼 수 있도록 자신만의 방식으로 변경을 하고 
			//		그 방법을 pSt에 담아 놓는다.
			//		아직은 SQL이 전송이 안된 상태이다.
			pSt = dbConn.prepareStatement(strSql);
		
			
			// 방금 dbConn을 통해서 pSt에 담은 정보를 사용하여
			// SQL문을 실행하도록 DB에게 전달하여 결과를 ResultSet에 받아라.
			
			// 그럼 SQL문은 우리에게 Table을 보낼 것이다.
			ResultSet result = pSt.executeQuery();
			
			// ResultSet에는 SELECT문을 실행한 결과인 Table이 담겨 있게 된다.
			// DB Cursor
			// Table이 담겨있는 유사 List 자료형
			// 값을 추출 할 때 처음부터 순서대로 전진방향으로만 추출 할 수 있다.
			
			// 최초에 next실행햇을 때 데이터가 없으면 false를 담아서 while문을 빠져나옴
			// 데이터가 있으면 첫번재, 두번째 , 세번째 값을 찾아서 각각 추출한다.
			// get을 통해 값 추출
			/*
			 * 썜) ResultSet의 next() method를 호출하면
			 * SELECT 결과물이 없으면 false를 return하고
			 * 결과물이(Table Record)이 있으면 record로부터 데이터를 칼럼별로 추출할 수 있도록
			 * 대기 상태가 된다.
			 */
			while(result.next()) {
				
				OrderVO orderVO = new OrderVO();
				String o_num = result.getNString(DBContract.ORDER.POS_O_CNUM_STR);
				o_num = result.getNString(DBContract.ORDER.POS_O_CNUM_STR);
				orderVO.setO_num(o_num);
				
				String o_cnum = result.getNString(DBContract.ORDER.POS_O_CNUM_STR);
				orderVO.setO_cnum(o_cnum);
				
				int o_price = result.getInt(DBContract.ORDER.POS_O_PRICE_INT);
				orderVO.setO_price(o_price);
				
				String o_pcode = result.getNString(DBContract.ORDER.POS_O_PCODE_STR);
				orderVO.setO_pcode(o_pcode);
				
				orderList.add(orderVO);
				
				
				
				System.out.println(result.getNString(1));
			}
			result.close();
			dbConn.close();
			
			System.out.println("======================================================");
			System.out.println("주문내역");
			System.out.println("------------------------------------------------------");
			System.out.println("주문번호\t고객번호\t상품번호");
			for(OrderVO vo : orderList) {
				
				System.out.print(vo.getO_num() + "\t\t");
				System.out.print(vo.getO_cnum()+ "\t\t");
				System.out.print(vo.getO_pcode() + "\n");
				
			}
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			System.out.println("프로젝트에 오라클 드라이버가 설치되지 않았습니다.");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			// SQLException 문제가 엄청 다양하기 때문에 예외를 열어둬서 어디에서 문제가 생긴건지 알게 해준다.
			// 안그럼 SQL문제중에 과연 어떤 점이 문제가 발생한 것인지를 알 수가 없다.
			e.printStackTrace();
			//System.out.println("오라클에 접속하는 과정에서 문제가 발생했습니다.");
		}
		
		
		
		
	}

}
