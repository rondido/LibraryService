package Pack01;

import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

class OTP{
	private static long create(long time) throws Exception {
		final String ALGORITHM = "HmacSHA1";
		final byte[] SECRET_KEY = "define your secret key here".getBytes();

		byte[] data = new byte[8];

		long value = time;
		for (int i = 8; i-- > 0; value >>>= 8) {
			data[i] = (byte) value;
		}

		Mac mac = Mac.getInstance(ALGORITHM);
		mac.init(new SecretKeySpec(SECRET_KEY, ALGORITHM));

		byte[] hash = mac.doFinal(data);
		int offset = hash[20 - 1] & 0xF;

		long truncatedHash = 0;
		for (int i = 0; i < 4; ++i) {
			truncatedHash <<= 8;
			truncatedHash |= hash[offset + i] & 0xFF;
		}

		truncatedHash &= 0x7FFFFFFF;
		truncatedHash %= 1000000;

		return truncatedHash;
	}

	public static String create() throws Exception {
		final long DISTANCE = 1000; // 30 sec
		return String.format("%06d", create(new Date().getTime() / DISTANCE));
	}

	public static boolean vertify(String code) throws Exception {
		return create().equals(code);
	}
}

@Controller
public class Router {
	UserDao userDao = new UserDao();
	AdminDao adminDao = new AdminDao();
	CheckOutDao checkoutDao = new CheckOutDao();
	
	// 유나-------------------------------------------------------------------------------
	@RequestMapping("/load") // 길찾기 클릭시, 화면
	public String load() {
		return "loadView";
	}
	@RequestMapping("/login") // 로그인 화면
	public String login() {
		return "loginView";
	}
	@RequestMapping("/join") // 회원가입 화면
	public String join() {
		return "joinView";
	}
	
	@RequestMapping("/loginPro") // 로그인 실행(성공 여부에 따른 뷰 변환)
	public String loginPro(
			HttpServletRequest request,
			Model model, 
			HttpSession httpSession, 
			userLoginDTO userloginDTO,
			adminLoginDTO adminloginDTO
			) {

		String id = request.getParameter("userID");
		
		boolean loginResult;
		if(id.equals("")) {
			System.out.println("관리자 로그인");
			loginResult = adminDao.loginPro(adminloginDTO); // 관리자 로그인 성공 여부 확인
			if(loginResult==true) {
				httpSession.setAttribute("SessionID", adminloginDTO.getAdminID());
				httpSession.setAttribute("flag", "A");
			}
		}else {
			System.out.println("사용자 로그인");
			loginResult = userDao.loginPro(userloginDTO); // 사용자 로그인 성공 여부 확인
			if(loginResult==true) {
				httpSession.setAttribute("SessionID", userloginDTO.getUserID());
				httpSession.setAttribute("flag", "U");
			}
		}
		System.out.println((loginResult==true)?"로그인 성공":"로그인 실패");
		model.addAttribute("loginSuccess", loginResult);
		return (loginResult==true)? "redirect:/": "loginView";
	}
	
	@RequestMapping("joinPro") // 회원가입 실행
	public String joinPro(UserDTO u) {
		userDao.insert(u);
		return "loginView";
	}
	
	@ResponseBody
	@RequestMapping(value="/idcheck", method= RequestMethod.POST)
	public String idcheck(UserDTO id){
		System.out.println(id.getUserID());
		
	    boolean m = userDao.checkid(id.getUserID());
	    String message=null;
	    
	    if(m) {//사용할 수 있다. db에서 찾았는데없으니까
	        message = "success";
	    }else {//사용할 수 없다.
	        message ="fail";
	    }	
	    return message;
	}
	
	@RequestMapping("/logout") // 로그아웃
	public String joinPro(HttpSession httpSession) {
		System.out.println("로그아웃");
		httpSession.invalidate(); // 무결하게
		return "redirect:/";
	}
	
	@RequestMapping("/borrow") // 대출 임시 경로
	public String adminpage(Model model) {
		System.out.println("관리자 페이지 진입");
		List<checkOutDTO> checkresult = checkoutDao.showPro();
		model.addAttribute("checkresult", checkresult);
		System.out.println(checkresult);
		System.out.println("데이터 들고왔어용");
		return "borrowView";
	}
	
	
	  @ResponseBody
	  @RequestMapping(value="/checkOutRegister", method= RequestMethod.POST) 
	  public String checkOutRegister(HttpServletRequest request){ 
		  
	  int bookid = Integer.parseInt(request.getParameter("bookID")); // 책 아이디
	  String userid = request.getParameter("userID"); // 사용자 아이디
	  checkOutDTO checkoutDto = new checkOutDTO(); 
	  checkoutDto.setBookID(bookid);
	  checkoutDto.setUserID(userid);
	  System.out.println("여기까지왔다."+bookid);
	  System.out.println("여기까지왔다."+userid);
	  List<CheckOutBean> check = checkoutDao.checkBookID(bookid); // 중복되는 bookID가 checkState  있는지 
	  String message=null; 
	  if(check != null) { // 대충된 bookid가 있디 = 데츨불가능
		  
		  message ="fail"; 
	  }
	  else {// 대출중인 bookID가 없다
		  String isbn = checkoutDao.findISBN(bookid); // ISBN
		  checkoutDto.setISBN(isbn); 
		  checkoutDao.insertCheckOut(checkoutDto); 
		  
		  CheckOutDao.updateCheckOut(bookid);
		  
		  message ="success"; 
	  } return message; 
}
	 
		/*
		 * @ResponseBody
		 * 
		 * @RequestMapping(value="/checkOutRegister", method= RequestMethod.POST) public
		 * void checkOutRegister(HttpServletRequest request){ int bookid =
		 * Integer.parseInt(request.getParameter("bookID")); // 책 아이디 String userid =
		 * request.getParameter("userID"); // 사용자 아이디
		 * 
		 * checkOutDTO checkoutDto = new checkOutDTO(); checkoutDto.setBookID(bookid);
		 * checkoutDto.setUserID(userid); System.out.println("여기까지왔다."+bookid);
		 * System.out.println("여기까지왔다."+userid);
		 * 
		 * checkoutDao.insertCheckOut(checkoutDto); }
		 */
	  
	// 아이디 찾기 클릭
		@RequestMapping("/findid") //----------------이거 추가했어요!!!!!
		public String findid() {
			return "findidView";
		}

		// 비밀번호 찾기 클릭
		@RequestMapping("/findpw") //----------------이거 추가했어요!!!!!
		public String findpw() {
			return "findpwView";
		}

		// 번호 인증하기
		@ResponseBody
		@RequestMapping(value="/send", method= RequestMethod.POST) //----------------이거 추가했어요!!!!!
		public String send(Model model) {
			System.out.println("send");
			String code = null;
			try {
				OTP otp = new OTP();
				code = otp.create();
				System.out.println("hiiii"+code);
				System.out.println("hello"+otp.vertify(code));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// 아래에는 문자를 진짜 보내기 때문에, 실제로 시연 영상할떄 사용할 것이다!!!!! 주석 해제하거나 삭제하지 마세요ㅠㅠ
			String api_key = "NCSHMNQ2F6RSPUR2";
		    String api_secret = "MHVTREMTC8IXI0HIR4QKOZLTVI9BKGSP";
		    Message coolsms = new Message(api_key, api_secret);
	
		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", "01092981199");
		    params.put("from", "01092981199");
		    params.put("type", "SMS");
		    params.put("text", "인증번호는 "+ code +"입니다.");
		    params.put("app_version", "test app 1.2"); // application name and version
	
		    try {
		      JSONObject obj = (JSONObject) coolsms.send(params);
		      System.out.println(obj.toString());
		    } catch (CoolsmsException e) {
		      System.out.println(e.getMessage());
		      System.out.println(e.getCode());
		    }
			model.addAttribute("code", code);
			System.out.println("---"+code);
			return code;
		}


		// 아이디 찾기 체크
		@RequestMapping("/findidcheck") //
		public String findidcheck(HttpServletResponse response, Model model, User user) {
			String id = userDao.returnID(user);
			System.out.println("id------------"+id);

			response.setContentType("text/html; charset=UTF-8");
			if (id==null) {
				try {
					PrintWriter out = response.getWriter();

					out.println("<script>alert('해당하는 정보가 없습니다.'); </script>");
					out.flush();
					return "findidView";

				} catch (Exception e) {
					// TODO: handle exception
				}
			}else {
				try {
					PrintWriter out = response.getWriter();

					out.println("<script>alert('찾으신 아이디는 "+ id + "입니다.'); </script>");
					out.flush();
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			return "loginView";
		}

		// 비번 찾기 체크
		@RequestMapping("/findpwcheck")
		public String findpwcheck(HttpServletResponse response, Model model, User user) {
			String id = userDao.returnID(user);
			System.out.println("id------------"+id);

			response.setContentType("text/html; charset=UTF-8");
			if (id==null) {
				try {
					PrintWriter out = response.getWriter();

					out.println("<script>alert('해당하는 정보가 없습니다.'); </script>");
					out.flush();
					return "findpwView";

				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			model.addAttribute("idd", id);
			return "changePWView";
		}

		@RequestMapping("/changepwgo") //----------------이거 추가했어요!!!!!
		public String changepwgo(HttpServletResponse response, User user) {
			System.out.println("변경할 아이디 들고왔다."+user.getUserID()+user.getUserPW());
			userDao.changePW(user);
			response.setContentType("text/html; charset=UTF-8");
			try {
				PrintWriter out = response.getWriter();
				out.println("<script>alert('비밀번호가 변경되었습니다.'); </script>");
				out.flush();
			} catch (Exception e) {
				// TODO: handle exception
			}
			return "loginView";
		}


	// 나은------------------------------------------------------------------------------
	@RequestMapping("/notice")
	public String notice() {
		return "noticeView";
	}
	@RequestMapping("/mypage")
	public String mypage(Model model, String userID) {
		// session의 id 들고옴
		// id 로 user테이블 조회 list
		// 예약, 대출테이블에서 카운팅 int
		// view 페이지로 결과 던져주기
		UserDao dao = new UserDao();
		User userOne = dao.showUser(userID);
		model.addAttribute("userOne",userOne);
		System.out.println(userOne);
		int checkCount = dao.checkCount(userID);
		model.addAttribute("checkCount",checkCount);
		
		int reservationCount = dao.reservationCount(userID);
		model.addAttribute("reservationCount",reservationCount);
		
		BookDAO ddao = new BookDAO();
		int likeCount = ddao.likeCount(userID);
		
		model.addAttribute("likeCount",likeCount);
		
		return "mypageView";
	}
	@RequestMapping("/faq")
	public String faq() {
		return "faq";
	}
	@RequestMapping("/help")
	public String help() {
		return "helpView";
	}
	
	@RequestMapping("/checkout")
	public String checkout(Model model,String userID) {
		
		BookDAO dao = new BookDAO();
		List<CheckOutBean> checkList = dao.checkList(userID);
		model.addAttribute("checkList",checkList);
		
		UserDao udao = new UserDao();
		int checkCount = udao.checkCount(userID);
		model.addAttribute("checkCount",checkCount);
		
		
		System.out.println(checkCount);
		
		System.out.println("check controller");
		
		return "checkoutView";
	}
	
	@RequestMapping("/reservation")
	public String reservation(Model model,String userID) {
		
		BookDAO dao = new BookDAO();
		List<BookBean> reserList = dao.reserList(userID);
		model.addAttribute("reserList",reserList);
		
		UserDao udao = new UserDao();
		int reservationCount = udao.reservationCount(userID);
		model.addAttribute("reservationCount",reservationCount);
		
		return "reservationView";
		
	}
	@RequestMapping("deleteReser")
	public String deleteReser(Model model,HttpSession session, int reserNum,int bookID) {
		
		UserDao dao = new UserDao();
		
		String userID = (String) session.getAttribute("SessionID");
		
		dao.deleteReser(reserNum,bookID);
		
		
		return "redirect:/reservation?userID="+userID;
	}
	
	@RequestMapping("bookDetail")
	public String bookDetail(Model model , String ISBN){
		BookDAO dao = new BookDAO();
		List<BookBean> detailBook = dao.bookDetail(ISBN);
		
		int count = dao.bookCount(ISBN);
		System.out.println(count+"count!@!@!@!@@!!@!@!@");
		System.out.println(ISBN+"ISBN!@!@@!!@!@!@!@!@@@!!@!@");
		model.addAttribute("detailBook",detailBook);
		model.addAttribute("count",count);
		return "bookDetailView";
	}
	
	@RequestMapping("delay")
	public String delayApply(Model model, HttpServletRequest request) {
		int data = 0;
		int checkNum = Integer.parseInt(request.getParameter("checkNum"));
		System.out.println("check"+checkNum);
		BookDAO dao = new BookDAO();
		data = dao.delayApply(checkNum);
		
		model.addAttribute("data",data);
		return "data";
	}
	@RequestMapping("reserAdd")
	public String reserAdd(Model model, HttpServletRequest request) {
		int data = 0;
		int bookID = Integer.parseInt(request.getParameter("bookID"));
		String ISBN = request.getParameter("ISBN");
		String checkInDate = request.getParameter("checkInDate");
		String userID = request.getParameter("userID");
		
		BookDAO dao = new BookDAO();
		ReservationBean rbean = new ReservationBean();
		rbean.setBookID(bookID);
		rbean.setISBN(ISBN);
		rbean.setUserID(userID);
		rbean.setPickDate(checkInDate);
		
		data = dao.reserAdd(rbean);
		
		model.addAttribute("data",data);
		return "data";
	}
	@RequestMapping("like")
	public String like(Model model ,String userID) {
		
		BookDAO dao = new BookDAO();
		List<like> likeBook = dao.likeBook(userID);
		model.addAttribute("likeBook",likeBook);
		System.out.println(likeBook+"dojfoijdso");
		
		int likeCount = dao.likeCount(userID);
		model.addAttribute("likeCount",likeCount);
		
		return "likeView";
	}
	@RequestMapping("infoCheck")
	public String infoCheck(Model model, String userID) {
		
		return "infoCheckView";
	}
	@ResponseBody
	@RequestMapping("userCheck")
	public String userCheck(Model model,HttpServletRequest request){
		int check = 0;
		String result = null;
		UserDao dao = new UserDao();
		
		String userID = request.getParameter("userID");
		String userPW = request.getParameter("userPW");
		

		
		userLoginDTO dto = new userLoginDTO();
		dto.setUserID(userID);
		dto.setUserPW(userPW);
		
		check = dao.userCheck(dto);
		System.out.println(check+"!!!!!!!!!!CHECK@@@@@@@@@@@@");
		if(check != 0) {
			int r = dao.deleteUser(dto);
			if(r != 0) {
				result = "success";
			}else {
				result ="fail";
			}
		}else {
			result = "fail";
		}
		
		return result;
	}

	@ResponseBody
	@RequestMapping("likeOn")
	public String likeOn(HttpServletRequest request) {
		String result = null;
		int check = 0;
		HttpSession session = request.getSession();
		
		String ISBN = request.getParameter("ISBN");
		String userID = (String)session.getAttribute("SessionID");
		UserDao dao = new UserDao();
		if(userID == null) {
			userID = "";
			result = "error";
		}else {
			check= dao.likeOn(ISBN,userID);
			if(check != 0) {
				result ="success";
			}else {
				result ="error";
			}
		}
		
		return result;
	}
	@ResponseBody
	@RequestMapping("likeOff")
	public String likeOff(HttpServletRequest request) {
		String result = null;
		int check = 0;
		HttpSession session = request.getSession();
		
		String ISBN = request.getParameter("ISBN");
		String userID = (String)session.getAttribute("SessionID");
		
		System.out.println(ISBN+"DKK#@#@#@#@#@#@#@@#@");
		System.out.println(userID+"DD@@@@@########");
		UserDao dao = new UserDao();
		if(userID == null) {
			userID = "";
			result ="error";
		}else {
			check = dao.likeOff(ISBN,userID);
			if(check !=0) {
				result ="success";
			}else {
				result = "error";
			}
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("isLike")
	public String isLike(HttpServletRequest request) {
		
		String result = null;
		HttpSession session = request.getSession();
		
		String userID = (String)session.getAttribute("SessionID");
		String ISBN = request.getParameter("ISBN");
		
		UserDao dao = new UserDao();
		int check = 0;
		check = dao.isLike(userID,ISBN);
		
		if(check != 0) {
			result = "success";
		}else {
			result = "error";
		}
		
		return result;
	}
	
	//// 진현------------------------------------------------------------------------------
	@RequestMapping("/introduce")
	public String introduce() {
		return "introduceView";
	}
	
	///진웅------------------------------------------------------------------------------
	@RequestMapping("/search")
	public String search() {
		return "searchView";
	}
	@RequestMapping("/bestBook")
	public String bestBook() {
		return "bestBookView";
	}
}
