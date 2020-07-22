package com.biz.dbms.config;

public class DBContract {
	
	public final static String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
	// package Explorer > Referenced Libraries > ojdbc6.jar > oracle.jdbc.driver > OracleDriver.claa에서
	// 마우스 오른쪽 클릭 copy Qualified Name 클릭 후 붙여넣기 한 후 뒤의 .class는 지워준다.
	public final static String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe"; 
	public final static String DB_USER = "user2";
	public final static String DB_PASSWORD = "user2";
	
	public final static String ORDER_DELETE =
			" DELETE FROM "
			+ ORDER.TABLE  
			+ " WHERE "
			+ ORDER.COL_O_SEQ_LONG + "= ?";
	
	
	public final static String ORDER_UPDATE =
			" UPDATE "
			+ ORDER.TABLE 
			+ " SET " 
			+ ORDER.COL_O_NUM_STR + "= ?,"	
			+ ORDER.COL_O_DATE_STR + "= ?,"
			+ ORDER.COL_O_CNUM_STR + "= ?,"
			+ ORDER.COL_O_PCODE_STR + "= ?,"
			+ ORDER.COL_O_PNAME_STR + "= ?,"
			+ ORDER.COL_O_PRICE_INT + "= ?,"
			+ ORDER.COL_O_QTY_INT	 + "= ?,"
			+ ORDER.COL_O_TOTAL_INT + "= ?"
			+ " WHERE "
			+ ORDER.COL_O_SEQ_LONG + "= ?";
	
	public final static String ORDER_INSERT =
				" INSERT INTO "
				+ ORDER.TABLE + "("
				+ ORDER.COL_O_SEQ_LONG + ","			
				+ ORDER.COL_O_NUM_STR + ","	
				+ ORDER.COL_O_DATE_STR + ","
				+ ORDER.COL_O_CNUM_STR + ","
				+ ORDER.COL_O_PCODE_STR + ","
//				+ ORDER.COL_O_PNAME_STR + ","
//				+ ORDER.COL_O_PRICE_INT + ","
//				+ ORDER.COL_O_QTY_INT	 + ","
				+ ORDER.COL_O_TOTAL_INT 
				+ " ) VALUES ( "
				+ " SEQ_ORDER.NEXTVAL,?,'2020-07-21',?,?,? )";
//				+ " )VALUES(" 
//				+ " ?,?,?,?,?,?,?,?,? "
//				+ ")";
					
	public final static String ORDER_SELECT =
			" SELECT "
			+	ORDER.COL_O_SEQ_LONG + ","			
			+	ORDER.COL_O_NUM_STR + ","	
			+	ORDER.COL_O_DATE_STR + ","
			+	ORDER.COL_O_CNUM_STR + ","
			+	ORDER.COL_O_PCODE_STR + ","
			+	ORDER.COL_O_PNAME_STR + ","
			+	ORDER.COL_O_PRICE_INT + ","
			+	ORDER.COL_O_QTY_INT	 + ","
			+	ORDER.COL_O_TOTAL_INT 
			+	" FROM " + ORDER.TABLE;
	 		
	public static class ORDER {
		 public final static String TABLE 			= "TBL_ORDER"; 
		 public final static String COL_O_SEQ_LONG 	= " o_seq ";		//NUMBER
		 public final static String COL_O_NUM_STR 	= " o_num ";		//CHAR(6 BYTE)
		 public final static String COL_O_DATE_STR 	= " o_date ";		//CHAR(10 BYTE)
		 public final static String COL_O_CNUM_STR 	= " o_cnum ";		//CHAR(5 BYTE)
		 public final static String COL_O_PCODE_STR = " o_pcode ";	//CHAR(6 BYTE)
		 public final static String COL_O_PNAME_STR = " o_pname ";	//NVARCHAR2(125 CHAR)
		 public final static String COL_O_PRICE_INT = " o_price ";	//NUMBER
		 public final static String COL_O_QTY_INT	= " o_qty ";		//NUMBER
		 public final static String COL_O_TOTAL_INT = " o_total ";	//NUMBER
		 
		 // 컴퓨터에서는 모든 숫자는 0부터 시작하지만 여기서는 배열번호가 1번부터 시작한다...
		 public final static int POS_O_SEQ_LONG 	=1; //NUMBER
		 public final static int POS_O_NUM_STR 		=2; //CHAR(6 BYTE)
		 public final static int POS_O_DATE_STR 	=3; //CHAR(10 BYTE)
		 public final static int POS_O_CNUM_STR 	=4; //CHAR(5 BYTE)
		 public final static int POS_O_PCODE_STR 	=5; //CHAR(6 BYTE)
		 public final static int POS_O_PNAME_STR 	=6; //NVARCHAR2(125 CHAR)
		 public final static int POS_O_PRICE_INT 	=7; //NUMBER
		 public final static int POS_O_QTY_INT		=8; //NUMBER
		 public final static int POS_O_TOTAL_INT 	=9; //NUMBER
		
	}
	

}
