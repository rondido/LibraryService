package Pack01;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;


interface Commend2{
	int commend(SqlSession session);
}

class Proxy2{
	void m1(CheckOutDao dao, Commend2 c) {
		SqlSession session = dao.ssf.openSession();
				
		try {
			int result = c.commend(session);
			if (result>0) session.commit(); // Ŀ���� �ϸ� �ȴ�.
		} catch (Exception e) { e.printStackTrace(); 
		} finally { session.close(); }
	}
}

public class CheckOutDao{
	static SqlSessionFactory ssf = null;
	
	public CheckOutDao() {
		try {
			InputStream is = Resources.getResourceAsStream("mybatis-config.xml");
			System.out.println("--------------------------------");
			ssf = new SqlSessionFactoryBuilder().build(is);
			System.out.println(ssf==null);
		} catch (Exception e) { e.printStackTrace(); }
	}
	
	// ������ ���
	public List<checkOutDTO> showPro() {
		System.out.println("������ ��� ����");
		
		SqlSession session = ssf.openSession();
		List<checkOutDTO> result = session.selectList("conCheckOUt");
		return result;
	}
	
	// ISBN ���
	public String findISBN(int bookid) {
		System.out.println("ISBN ã�� ����");
		SqlSession session = ssf.openSession();
		String isbn = null;
		try {
			isbn = session.selectOne("findISBN", bookid);
			session.commit(); // Ŀ���� �ϸ� �ȴ�.
		} catch (Exception e) { e.printStackTrace(); 
		} finally { session.close(); }
		return isbn;
	}
	
	// bookid Ȯ���ϱ� (�����ϴ� ��Ȳ���� bookID�� �ߺ��Ǵ� ���� �ִٸ�, ������ �� �� ����(fail)     /    �ߺ��Ǵ� ���� ���ٸ�, ������ �� �� �ִ�.(success))
	public List<CheckOutBean> checkBookID(int bookid) {
		System.out.println("bookid ����");
		System.out.println(bookid+"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		SqlSession session = ssf.openSession();
		List<CheckOutBean> a = null;
		try {
//			bookID = session.selectOne("checkBookID", bookid);
			a = session.selectList("checkBookID", bookid);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close(); 
		}
		return a;
	}
	
	public void insertCheckOut(checkOutDTO checkoutDto) {
		System.out.println("����å ���ε� ����");
		SqlSession session = ssf.openSession();
		session.insert("insertCheckOut", checkoutDto);
		System.out.println("hi!!!!!!!!!!!!!!!!!!!!!!----");
		session.commit(); // Ŀ���� �ϸ� �ȴ�.
		session.close(); 
	}

	public static void updateCheckOut(int bookid) {
		
		SqlSession session = ssf.openSession();
		session.update("updateCheckOut",bookid);
		session.commit();
		session.close();
		
	}
}