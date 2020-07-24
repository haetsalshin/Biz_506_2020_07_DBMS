package com.biz.order.controller;

import com.biz.order.service.OrderInput;

public class OrderImputEx_01 {

	
	public static void main(String[] args) {
		
		OrderInput oInput = new OrderInput();
		
		while(true){
			if(!oInput.orderInsert()) {
				
				break;
				
			}
		}
		System.out.println("입력종료 !!!");
		
		
		
	}
	
	
	
	

}
