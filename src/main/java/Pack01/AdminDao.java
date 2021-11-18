package Pack01;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

interface Commend1{
	int commend(SqlSession session);
}

class Proxy1{
	void m1(AdminDao dao, Commend1 c) {
		SqlSession session = dao.ssf.openSession();
				
		try {
			int result = c.commend(session);
			if (result>0) session.commit(); // 커밋을 하면 된다.
		} catch (Exception e) { e.printStackTrace(); 
		} finally { session.close(); }
	}
}

public class AdminDao {
	SqlSessionFactory ssf = null;
	
	public AdminDao() {
		try {
			InputStream is = Resources.getResourceAsStream("mybatis-config.xml");
			ssf = new SqlSessionFactoryBuilder().build(is);
		} catch (Exception e) { e.printStackTrace(); }
	}
	
	public void insert(AdminDTO a) {
		Proxy1 t = new Proxy1();
		t.m1(this, new Commend1() {
			public int commend(SqlSession session) {
				return session.insert("userInsert", a);
			}
		});
	}
	
	public boolean loginPro(adminLoginDTO adminloginDTO) {
		SqlSession session = ssf.openSession();
		String result = session.selectOne("adminCheck", adminloginDTO);
		session.close();
		if (result == null) {
			return false;
		}
		return true;
	}
}