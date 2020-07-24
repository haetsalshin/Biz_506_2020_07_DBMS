package com.biz.order.config;
/*
 * mybatis-context.xml 파일을 읽어서
 * 설정된 값으로 SQLSesseionFactory를 만들게 된다.
 * DBMS에 SQL을 보내고, 받을 때 SQL을 DBMS가 알 수 있는 데이터로 변환하고
 * 		DBMS가 데이터(Table) 을 보낼 때 Java가 인식할 수 있는 데이터로 변환하고
 * 		
 * 		model 클래스(VO,DTO)에 데이터를 자동으로 추가해주는
 * 		기능을 수행한다.
 */

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class DBConnection {

	private static SqlSessionFactory sqlSessionFactory;
	private static String contextFile;
	
	static {
		contextFile = "com/biz/order/config/mybatis-context.xml";
		// 파일을 읽어서 무언가를 처리 할 수 있도록 inputstream 
		// 그런것들은 선언부와 처리부를 각각 만들어야 한다.
		InputStream inputStream = null;

		

		try {
			// mybatis를 이용해서 resource라는 클래스를 이용해서
			// contextFile을 읽어서 값을 세팅해야한다. 그런데 이것도 상당히 복잡하다.
			// 그것을 mybatis가 우리가 쓸 수 있도록 만들어준다.
			/*
			 * 쌤 ) org.apache.ibatis.io.Resources
			 * 		mybatis configuration 문서를 읽어서
			 * 		xml로 설정된 항목들을 가져와서 Mybatis에서 사용할 수 있는
			 * 		데이터 형태로 변환하여 inputStream에 저장해달라
			 */
			inputStream = Resources.getResourceAsStream(contextFile);
			
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			// builder야 내가 정보를 넘길테니 sesseionfactory를 만들어줘.
			// SqlSessionFactoryBuilder의 build() method에 Resources.get...(context)로 읽어들인
			// inputStream 객체를 매개변수로만 전달을 하면 
			// sqlSessionFactory를 만들어서 return 해준다.
			

			/*
			 *  쌤) sqlSesseionFactory는 프로젝트가 시작될 때 만들어져 JVM이 관리하는 객체가 된다.
			 *  		(static이기 때문에)
			 *  	만약 이 프로젝트를 어떤경로로 2번이상 작동을 시킨다면
			 *  	작동되는 횟수만큼 sqlSesseionFactory가 계속해서 생성이 될 것이다.
			 *  	sqlSessionFactory 객체는 하는 일이 꽤 많아서 생성하는 것 자체만으로도
			 *  	JVM입장에선 부담이 될 수 있다.
			 *  	그래서 sqlSessionFactory를 생성하기 전에 
			 *  	누군가 만들어서 사용중이라면 다시 만들지 않고 재활용을 할 수 있도록
			 *  	해 주는 것이 좋다.
			 *  	if(sql... == null) : 아직 아무도 sqlSessionFactory를 만들지 않았을 때만
			 *  	생성하도록 조건을 부여하는 것이다.
			 *  	보통 이러한 객체는 privatte로 선언하고, 생성에 조건을 부여하며
			 *  	getter method를 통해서 외부에서 가져다 쓸 수 있도록 한다.
			 *  
			 *  *** 이러한 패턴을 싱글톤 패턴(SingleTone Pattern)이라고 한다.
			 */
			if(sqlSessionFactory == null) {
				// java는 한프로젝트를 여러 유저가 연결하여 사용하는 경우가 많다.
				// 그런데 이 프로젝트는 한개의 JVM(한사람의 PC)을 쓰고 있다.
				// 만약 각각의 사람이 모두 Factory를 만든다면 JVM이 너무 부담스럽게 된다.
				// 그래서 한 사람만 Factory 만들고 그걸 재활용해서 사용하는 것.
				// SingleTone Pattern
				sqlSessionFactory = builder.build(inputStream);
				
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("sqlSessinFactory 생성 중 xml 파일 문제 발생");
			e.printStackTrace();
		}
		
		
		
		
		
	}
	public static SqlSessionFactory getSessionFactory() {
		return sqlSessionFactory;
	}
	
}
