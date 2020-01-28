package hong.jy.persistence;

import java.sql.DriverManager;
import java.sql.Connection;

import org.junit.Test;



public class MySQLConnectionTests {
	
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/hong?serverTimezone=UTC";
	private static final String USER = "hong";
	private static final String PW = "java";
	
	@Test
	public void testConnection() throws Exception{
		
		Class.forName(DRIVER);
		try(Connection con = DriverManager.getConnection(URL, USER, PW)) {
			System.out.println("connection 출력�:"+con);
		}catch(Exception e) {
			System.out.println(e);
		}
	}

}
