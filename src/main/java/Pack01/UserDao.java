package Pack01;

import java.io.InputStream;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

interface Commend{
	int commend(SqlSession session);
}

class Proxy{
	void m1(UserDao dao, Commend c) {
		SqlSession session = dao.ssf.openSession();
				
		try {
			int result = c.commend(session);
			if (result>0) session.commit(); // Ŀ���� �ϸ� �ȴ�.
		} catch (Exception e) { e.printStackTrace(); 
		} finally { session.close(); }
	}
}

public class UserDao{
	SqlSessionFactory ssf = null;
	
	public UserDao() {
		try {
			InputStream is = Resources.getResourceAsStream("mybatis-config.xml");
			System.out.println("--------------------------------");
			ssf = new SqlSessionFactoryBuilder().build(is);
			System.out.println(ssf==null);
		} catch (Exception e) { e.printStackTrace(); }
	}
	
	// ���� ----------------------------------------------------------------------------------------------------------
	// ȸ������ ��, ���̵� �ߺ� Ȯ��
	public boolean checkid(String userID) {
		SqlSession session = ssf.openSession();
		String result = session.selectOne("userCheckID", userID);
		session.close();
		if (result == null) {
			return true; // �ߺ��� ���̵� ���� ���, ȸ������ ����
		}
		return false; // �ߺ��� ���̵� �ִ� ���, ȸ������ �Ұ���
	}
	
	// ȸ������ ��, DB�� ������ ����
	public void insert(UserDTO u) {
		Proxy t = new Proxy();
		System.out.println(u.getUserID()+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		t.m1(this, new Commend() {
			public int commend(SqlSession session) {
				System.out.println("ȸ������ ���� �Ϸ�");
				return session.insert("userInsert", u);
			}
		});
		System.out.println("111111111111111111111111");		
	}
	
	// �α��� ��, ���� ��ġ Ȯ��
	public boolean loginPro(userLoginDTO userloginDTO) {
		System.out.println("�α��� ��, ���� ��ġ Ȯ��");
		SqlSession session = ssf.openSession();
		String result = session.selectOne("userCheck", userloginDTO);
		session.close();
		if (result == null) {
			return false; // �α��� ������ ���� ���� ���, �α��� �Ұ���
		}
		return true; // �α��� ������ �´� ���, �α��� ����
	}
	
	// �߰�!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		public String returnID(User user) {
			SqlSession session = ssf.openSession();
			String returnID = "";

			System.out.println("�̸� ��ȣ ���Դµ�,"+user.getUserName()+user.getPhone());
			try {
				returnID = session.selectOne("findIDcheck",user);
				System.out.println("id���Դٰ�,,,"+returnID);
			} catch (Exception e) {
				return "";
			}finally {
				session.close();
			}
			return returnID;
		}

		public String returnPW(User user) {
			SqlSession session = ssf.openSession();
			String returnPW = "";

			System.out.println("���̵� �̸� ��ȣ ���Դµ�,"+user.getUserID()+user.getUserName()+user.getPhone());
			try {
				returnPW = session.selectOne("findPWcheck",user);
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				session.close();
			}
			return returnPW;
		}

		public void changePW(User user) {
			Proxy t = new Proxy();
			t.m1(this, new Commend() {
				public int commend(SqlSession session) {
					return session.update("changePW", user);
				}
			});
		}
	
	// ���� ---------------------------------------------------------------------------------------------
	public User showUser(String userID) {
		SqlSession session = ssf.openSession();
		User user = new User();
		
		try {
			user = session.selectOne("showUser",userID);
			System.out.println(userID);
			System.out.println("db���� ����");
			
			System.out.println(user+" user");
			return user;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		System.out.println("�������");
		return user;
	}
	
	public int checkCount(String userID) {
		SqlSession session = ssf.openSession();
		int checkCount = 0;
		
		try {
			checkCount = session.selectOne("checkCount",userID);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return checkCount;
	}

	public int reservationCount(String userID) {
		SqlSession session = ssf.openSession();
		int reservationCount = 0;
		
		try {
			reservationCount = session.selectOne("reservationCount",userID);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return reservationCount;
	}

	public void deleteReser(int reserNum, int bookID) {
		SqlSession session = ssf.openSession();
		
		System.out.println("RESER"+reserNum);
		try {
			session.delete("deleteReser",reserNum);
			session.update("bReserUp1",bookID );
			session.update("cReserUp1",bookID );
			
			System.out.println(session.update("bReserUp1",bookID ));
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
		}
		
	}

	

	public int deleteUser(userLoginDTO dto) {
		SqlSession session = ssf.openSession();
		
		int result = session.delete("userDelete",dto);
		
		session.commit();
		session.close();
		return result;
	}

	public int userCheck(userLoginDTO dto) {
		
		System.out.println(dto.getUserID()+dto.getUserPW()+"@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		SqlSession session = ssf.openSession();
		String result = null;
		int check = 0;
		
		try {
			
			result = session.selectOne("userInfoCheck",dto);
			System.out.println(result+"@RESULT!@!@@!!@@!@@!");
			if(result != null) {
				check = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
			
		}
		return check;
	}

	public int likeOn(String ISBN, String userID) {
		int check = 0;
		
		SqlSession session = ssf.openSession();
		like like = new like();
		like.setISBN(ISBN);
		like.setUserID(userID);
		try {
			check = session.insert("likeOn",like);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
		}
		
		return check;
	}

	public int likeOff(String ISBN, String userID) {
		int check = 0;
		
		SqlSession session = ssf.openSession();
		like like = new like();
		like.setISBN(ISBN);
		like.setUserID(userID);
		
		try {
			check = session.delete("likeOff", like);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
		}
		
		return check;
	}

	public int isLike(String userID, String ISBN) {
		int check = 0;
		SqlSession session = ssf.openSession();
		like like = new like();
		like.setISBN(ISBN);
		like.setUserID(userID);
		
		String result = null;
		result = session.selectOne("isLike",like);
		
		if(result != null) {
			check = 1;
		}
		
		session.close();
		
		return check;
	}

	
}