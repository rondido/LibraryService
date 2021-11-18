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

	// ISBN으로 책 검색하기
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
	
	// 예약하기 예약테이블에 추가, book테이블에 예약현황 변경, checkout 테이블 예약현황 변경 O로 변경
	public int reserAdd(ReservationBean reservationBean) {
		
		int result =0;
		System.out.println("reserAdd");
		session = ssf.openSession();
		System.out.println(reservationBean.getPickDate());
		System.out.println(reservationBean.getUserID()+"SSSSSSSSSSSSSSSSSSSSSSS");
		try {
			// 예약 테이블에 추가
			result = session.insert("reserAdd",reservationBean);
			System.out.println("result"+result);
			
			// insert 성공시
			if(result != 0) {
				// bookID 로 조회해서 변경
				// book 예약 현황 O로 변경
				session.update("bReserUp",reservationBean);
				//checkout 예약 현황 O로 변경
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
