package com.biz.order.controller;

import com.biz.order.model.OrderVO;

public class ParamEx_01 {
	
	public static void main(String[] args) {
		
		ParamTest pTest = new ParamTest();
		
		/*
		 * Primitive형 변수는 다른 method에 매개변수로 전달했을 때
		 * 전달받은 method에서 값을 변경해도 매개변수로 보낸 곳에서
		 * 원래 있던 값은 절대 변함이 없다.
		 */
		
		int intNum1 = 3;
		int intNum2 = 4;
		pTest.add(intNum1, intNum2);
		System.out.printf("intNum1 : %d, intNum2 : %d", intNum1, intNum2);
		System.out.println();
		/*
		 * class형 변수는 다른 method에 매개변수로 전달했을 떄
		 * 전달받은 method에서 객체의 일부요소(필드변수)를 변경하면
		 * 보낸 곳의 원본 데이터가 변해버린다.
		 */
		OrderVO oV = new OrderVO();
		System.out.println(oV.getO_pcode());
		pTest.add(oV);
		System.out.println(oV.getO_pcode());
		
		/*
		 * 배열을 다른 method에 매개변수로 전달 했을 때
		 * 전달 받은 method에서 배열의 일부요소 값을 변경하면
		 * 보낸 곳의 원본 배열도 데이터가 변해버린다. 
		 */
		
		int[] intA = new int[3];
		System.out.println(intA[0]);
		pTest.add(intA);
		System.out.println(intA[0]);
		
		/*
		 * 객체나, 배열을 매개변수로 전달했을 떄 
		 * 전달받은 method에서 새로(new) 객체나 배열을 생성하게 되면
		 * 원본 객체나 배열과는 전혀 다른 대상이 된다.
		 * 따라서 아무리 전달받은 method에서 값을 변경해도
		 * 원본은 값을 알 수 없다. 
		 */
		
		System.out.println("===========================================");
		System.out.println(oV.getO_pcode()); // 알 수 없음
		oV =pTest.non(oV);
		System.out.println(oV.getO_pcode()); // 나는 누구이게
		
		
	
		System.out.println(intA[0]); // 1000000000
		// 이런식으로 다시 선언을 해주어야 바뀐 값을 받을 수 있다
		intA = pTest.non(intA);
		System.out.println(intA[0]); // 33333333
		
		/*
		 * wrapper(String, Integer, Long, Float, Boolean, Character)들은
		 * primitive 변수와 성질이 닮았다.
		 */
		
		String str = "대한민국";
		System.out.println(str);
		pTest.add(str);
		System.out.println(str);
		
		
		Integer i = 99999;
		System.out.println(i);
		pTest.add(i);
		System.out.println(i);
		
		
		
		
	}

}
