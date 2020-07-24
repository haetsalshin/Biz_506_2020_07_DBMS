package com.biz.order.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Scanner;

import com.biz.order.mapper.OrderDao;
import com.biz.order.model.OrderVO;

public class OrderInput {
	
	private OrderService oService;
	private Scanner scan;
	private OrderDao orderDao;
	
	public OrderInput() {
		// TODO Auto-generated constructor stub
		
		oService = new OrderServiceImplV1();
		scan = new Scanner(System.in);
	}
	public boolean orderInsert() {
		OrderVO orderVO= new OrderVO();
		// orderVO : 새로 생성된 아무런 값도 없는 상태
		boolean ret = this.orderInput(orderVO);
		// orderVO : 입력한 주문서 정보가 담긴 상태
		if(ret) {
			
			if(oService.insert(orderVO)>0) {
				System.out.println("주문서 등록(추가) 성공");
				
			}else {
				System.out.println("주문서 등록 실패");
			}
		}
		
		return ret;
		
	}
	
	
	
	public boolean orderInput(OrderVO orderVO) {
		
		
		// 만약 orderUpdate() method에서 orderInput()을 호출했으면
		// orderVO의 각 필드변수들은 값을 가지고 있을 것이고
		// orderInsert() method에서 호출했으면
		// orderVO의 각 필드 변수 값은 초기값 ""(String) 이거나 0(int, long)
		
		
		
		while(true) {
			
			System.out.printf("주문번호 (%s, QUIT:중단) >> ",
					orderVO.getO_num() == null ? "NEW" : orderVO.getO_num());
			String strNum = scan.nextLine();
			
			if(strNum.equals("QUIT")) {
				return false;
			}
			/*
			 *  만약 insert 상태일 경우
			 *  사용자가 주문번호를 입력하지 않으면 set)_num() method를 통과하고
			 *  아래쪽 isEmpty()의 유효성 검사에서 통과하지 못할 것이다.
			 *  
			 *  update 상태일 경우
			 *  입력받은 strNum은 isEmpty일 것이고
			 *  당연히 setO_num() method는 통과 해 버릴 것이다.
			 *  하지만 이미 DB에서 읽어온 값이 담겨 있으므로 
			 *  아래쪽 orderVO.getO_num().isEmpty()는 그냥 통과 할 것이다.
			 */
			orderVO.setO_num(strNum);
			
			
			if(!strNum.isEmpty()) {
				orderVO.setO_num(strNum);
				return true;
			}
			if(orderVO.getO_num().isEmpty()) {

				System.out.println("주문번호는 반드시 입력해야 합니다.");
				continue;
			}
			
			break;
		}
		
		
		
		while(true) {
			
			System.out.printf("고객번호 (%s, QUIT:중단) >> ",
					orderVO.getO_cnum() == null? "NEW":orderVO.getO_cnum());
			String strCNum = scan.nextLine();
			
			if(strCNum.equals("QUIT")) {
				return false;
			}
			if(!strCNum.isEmpty()) {
				orderVO.setO_cnum(strCNum);
			}
			
			orderVO.setO_cnum(strCNum);
			if(orderVO.getO_cnum().isEmpty()) {
				System.out.println("고객번호는 반드시 입력해야 합니다.");
				continue;
			}
			break;
		}
		
		
		
		while(true) {
			
			System.out.print("상품코드 (QUIT:중단) >> ");
			String strPcode = scan.nextLine();
			
			if(strPcode.equals("QUIT")) {
				return false;
			}
			
			if(!strPcode.isEmpty()) {
				orderVO.setO_pcode(strPcode);
			}
			
			orderVO.setO_pcode((strPcode));
			if(orderVO.getO_pcode().isEmpty()) {
				System.out.println("상품코드는 반드시 입력해야 합니다.");
				continue;
			}
			break;
		}
		
		
		
		while(true) {
			
			System.out.print("상품가격 (QUIT:중단) >> ");
			String strPrice= scan.nextLine();
			
			if(strPrice.equals("QUIT")) {
				return false;
			}
			
			int intPrice = 0;
			try {
				intPrice= Integer.valueOf(strPrice);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("상품가격은 숫자로만 입력하세요");
			}
			
			if(intPrice >0 ) {
				orderVO.setO_price(intPrice);
			}
			orderVO.setO_price(intPrice);
			if(orderVO.getO_price() < 1) {
				System.out.println("상품가격은 0이상이어야 합니다.");
				continue;
			}
			break;
			
		
		}
		
		while(true) {
			
			List<OrderVO> orderList = new ArrayList<OrderVO>();
			
			
			
			System.out.print("주문수량 (QUIT:중단) >> ");
			String strQty= scan.nextLine();
			
			if(strQty.equals("QUIT")) {
				return false;
			}
			
			int intQty = 0;
			try {
				intQty= Integer.valueOf(strQty);
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("주문수량은 숫자로만 입력하세요");
			}
			if(intQty > 0) {
				orderVO.setO_qty(intQty);
			}
			orderVO.setO_qty(intQty);
			if(orderVO.getO_qty() < 1) {
				System.out.println("주문수량은 0이상이어야 합니다.");
				continue;
			}
			break;
		
		}
	/*
		int ret = 0;
		String msg = "추가";
		if(orderVO.getO_seq() > 0) {
		
			ret = oService.update(orderVO);
			msg = "수정";
		}else {
			ret = oService.insert(orderVO);
		
		}
		if(ret > 0) {
			System.out.printf("주문서 %s 추가 성공!\n", msg);
		}else {
			System.out.printf("주문서를 %s 추가하지 못햇습니다\n.", msg);
			System.out.print("다시 입력해주세요");
		}
		
		return true;
	*/
	}
	

	
	public boolean orderUpdate() {
		
		System.out.println("================================================");
		System.out.println("주문서 수정");
		System.out.println("================================================");
		System.out.println("주문서 수정 요령");
		System.out.println("Prompt에 나타난 값을 확인하고");
		System.out.println("새로 입력하면 값 수정");
		System.out.println("그냥 Enter를 누르면 통과");
		System.out.println("================================================");
		
		
		System.out.print("변경하고 싶은 SEQ ( 종료 : QUIT, ENTER : 변경안함 ) >> ");
		String strSeq = scan.nextLine();
		if(strSeq.equals("QUIT")) {
			return false;
		}
		
		long longSeq = 0;
		try {
			longSeq = Long.valueOf(strSeq);
		} catch (NumberFormatException e) {
			// TODO: handle exception
			System.out.println("SEQ는 숫자만 입력가능합니다.");
			return false;
		}
		
		OrderVO orderVO = null;
		try {
			orderVO = oService.findBySeq(longSeq);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		if(orderVO == null) {
			System.out.println("SEQ에 해당하는 데이터가 없습니다.");
			return true;
		}
		// orderVO : DB에서 가져온 1개의 주문서가 담겨있다.
		boolean ret = this.orderInput(orderVO);
		// orderVO : orderInput에서 변경한 주문서가 담겨있다.
		if(ret) {
			if(oService.update(orderVO) > 0) {
				
				System.out.println("주문서 수정 완료!");
			}else {
				System.out.println("주문서 수정 실패!");
			}
		}
		return ret;
		
		System.out.print("변경할 주문번호 ( 종료 : QUIT, ENTER : 변경안함 ) >> " );
		String strNum = scan.nextLine();
		if(strNum.equals("QUIT")) {
			return false;
		}
		
		if(!strNum.isEmpty()) {
			orderVO.setO_num(strNum);
		}
		
		
		System.out.print("변경할 고객번호 ( 종료 : QUIT, ENTER : 변경안함 ) >> " );
		String strCNum = scan.nextLine();
		if(strCNum.equals("QUIT")) {
			return false;
		}
		
		if(!strCNum.isEmpty()) {
			orderVO.setO_cnum(strCNum);
		}
		
		System.out.print("변경할 상품코드 ( 종료 : QUIT, ENTER : 변경안함 ) >> " );
		String strPcode = scan.nextLine();
		if(strPcode.equals("QUIT")) {
			return false;
		}
		
		if(!strPcode.isEmpty()) {
			orderVO.setO_pcode(strPcode);
		}
		
		while(true) {
			
			System.out.print("변경할 상품가격 ( 종료 : QUIT, ENTER : 변경안함 ) >> " );
			String strPrice = scan.nextLine();
			
			if(strPrice.equals("QUIT")) {
				return false;
			}
			if(!strPrice.isEmpty()) {
				int intPrice = 0;
				try {
					
					intPrice = Integer.valueOf(strPrice);
					
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println("상품가격은 숫자만 입력가능합니다.");
					System.out.println("다시 입력해주세요");
					return true;
				}
				orderVO.setO_price(intPrice);
				
			}

			break;
		}
		
		while(true) {
			
			
			System.out.print("변경할 상품수량 ( 종료 : QUIT, ENTER : 변경안함 ) >> " );
			String strQty = scan.nextLine();
			
			if(strQty.equals("QUIT")) {
				return false;
			}
			
			if(!strQty.isEmpty()) {
				int intQty = 0;
				
				try {
					intQty = Integer.valueOf(strQty);
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println("상품 수량은 숫자만 입력가능합니다.");
					System.out.println("다시 입력해주세요");
					return true;
				}
				orderVO.setO_qty(intQty);
				
			}
			
			// 총액 변경
			orderVO.setO_total(orderVO.getO_qty() * orderVO.getO_price());
			
			break;
			
		}
		
		// 날짜는 입력하는 날짜로 자동 입력
		
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		

		orderVO.setO_date(df.format(date));
		
		int ret = oService.update(orderVO);
		if(ret > 0) {
			System.out.println("시스템 변경 완료");
			orderVO = oService.findBySeq(longSeq);
			
			System.out.println("==================================");
			System.out.println("주문번호 : " + orderVO.getO_num());
			System.out.println("고객번호 : " + orderVO.getO_cnum());
			System.out.println("상품코드 : " + orderVO.getO_pcode());
			System.out.println("상품가격 : " + orderVO.getO_price());
			System.out.println("상품수량 : " + orderVO.getO_qty());
			System.out.println("주문날짜 : " + orderVO.getO_date());
			System.out.println("==================================");
			
		} else {
			System.out.println("데이터 변경 실패");
		}
		
		
		return ret;
	}
	
		
	
	

	

}
