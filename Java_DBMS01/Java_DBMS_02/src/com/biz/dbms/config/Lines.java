package com.biz.dbms.config;

public class Lines {
	
	public static String dLine = "";
	public static String sLine = "";
	
	static {
		
		// 2가지 방법이 있다.
		// 1.
		//dLine = String.format("%0100d", 0);
		//dLine = dLine.replace("0", "=");
		
		//sLine = String.format("%0100d", 0);
		//sLine = dLine.replace("0", "-");
	
		
		// 2.
		String line = String.format("%0100d",0);
		dLine = line.replace("0", "=");
		sLine = line.replace("0", "-");
	}
	
	public static String getDLine(int length) {
		return String.format("%0"+length+"d",0).replace("0", "=");
	}
	public static String getSLine(int length) {
		return String.format("%0"+length+"d",0).replace("0", "-");
	}
}
