package Pack01;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;


public class BookDAO {
	SqlSessionFactory ssf = null;
	SqlSession session = null;
	public BookDAO() {
		try {
			InputStream is = Resources.getResourceAsStream("mybatis-config.xml");
			ssf = new SqlSessionFactoryBuilder().build(is);
		} catch (Exception e) { e.printStackTrace(); }
	}

	public List<CheckOutBean> checkList(String userID) {
		session = ssf.openSession();
		List<CheckOutBean> checkList = null;
		
		try {
			checkList = session.selectList("checkOutList",userID);
			System.out.println(checkList);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return checkList;
	}

	public List<BookBean> reserList(String userID) {
		session = ssf.openSession();
		List<BookBean> reserList = null;
		
		try {
			reserList = session.selectList("reserList",userID);
			System.out.println("reserList"+reserList);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return reserList;
	}

	// ISBN���� å �˻��ϱ�
	public List<BookBean> bookDetail(String ISBN) {
		
		session = ssf.openSession();
		List<BookBean> bookDetail = null;
		
		try {
			bookDetail = session.selectList("bookDetail",ISBN);

		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return bookDetail;
	}

	public int delayApply(int checkNum) {
		int data = 0;
		session = ssf.openSession();
		
		try {
			data = session.update("delayApply", checkNum);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
		}
		
		return data;
	}
	
	public int bookCount(String ISBN) {
		int count = 0;
		session = ssf.openSession();
		
		try {
			System.out.println(ISBN);
			int allcount = session.selectOne("allcount",ISBN);
			int recount = session.selectOne("recount",ISBN);
			
			count = allcount-recount;
			
			System.out.println(count);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return count;
	}
	
	// �����ϱ� �������̺� �߰�, book���̺� ������Ȳ ����, checkout ���̺� ������Ȳ ���� O�� ����
	public int reserAdd(ReservationBean reservationBean) {
		
		int result =0;
		System.out.println("reserAdd");
		session = ssf.openSession();
		System.out.println(reservationBean.getPickDate());
		System.out.println(reservationBean.getUserID()+"SSSSSSSSSSSSSSSSSSSSSSS");
		try {
			// ���� ���̺� �߰�
			result = session.insert("reserAdd",reservationBean);
			System.out.println("result"+result);
			
			// insert ������
			if(result != 0) {
				// bookID �� ��ȸ�ؼ� ����
				// book ���� ��Ȳ O�� ����
				session.update("bReserUp",reservationBean);
				//checkout ���� ��Ȳ O�� ����
				session.update("cReserUp",reservationBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.commit();
			session.close();
		}
		
		return result;
	}

	public List<like> likeBook(String userID) {
		session = ssf.openSession();
		List<like> likeBook = null;
		
		try {
			likeBook = session.selectList("likeBook",userID);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return likeBook;
	}

	public int likeCount(String userID) {
		int likeCount = 0;
		
		session = ssf.openSession();
		
		likeCount = session.selectOne("likeCount",userID);
		return likeCount;
	}
	
	
}
