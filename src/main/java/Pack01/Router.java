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
	
	// ����-------------------------------------------------------------------------------
	@RequestMapping("/load") // ��ã�� Ŭ����, ȭ��
	public String load() {
		return "loadView";
	}
	@RequestMapping("/login") // �α��� ȭ��
	public String login() {
		return "loginView";
	}
	@RequestMapping("/join") // ȸ������ ȭ��
	public String join() {
		return "joinView";
	}
	
	@RequestMapping("/loginPro") // �α��� ����(���� ���ο� ���� �� ��ȯ)
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
			System.out.println("������ �α���");
			loginResult = adminDao.loginPro(adminloginDTO); // ������ �α��� ���� ���� Ȯ��
			if(loginResult==true) {
				httpSession.setAttribute("SessionID", adminloginDTO.getAdminID());
				httpSession.setAttribute("flag", "A");
			}
		}else {
			System.out.println("����� �α���");
			loginResult = userDao.loginPro(userloginDTO); // ����� �α��� ���� ���� Ȯ��
			if(loginResult==true) {
				httpSession.setAttribute("SessionID", userloginDTO.getUserID());
				httpSession.setAttribute("flag", "U");
			}
		}
		System.out.println((loginResult==true)?"�α��� ����":"�α��� ����");
		model.addAttribute("loginSuccess", loginResult);
		return (loginResult==true)? "redirect:/": "loginView";
	}
	
	@RequestMapping("joinPro") // ȸ������ ����
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
	    
	    if(m) {//����� �� �ִ�. db���� ã�Ҵµ������ϱ�
	        message = "success";
	    }else {//����� �� ����.
	        message ="fail";
	    }	
	    return message;
	}
	
	@RequestMapping("/logout") // �α׾ƿ�
	public String joinPro(HttpSession httpSession) {
		System.out.println("�α׾ƿ�");
		httpSession.invalidate(); // �����ϰ�
		return "redirect:/";
	}
	
	@RequestMapping("/borrow") // ���� �ӽ� ���
	public String adminpage(Model model) {
		System.out.println("������ ������ ����");
		List<checkOutDTO> checkresult = checkoutDao.showPro();
		model.addAttribute("checkresult", checkresult);
		System.out.println(checkresult);
		System.out.println("������ ���Ծ��");
		return "borrowView";
	}
	
	
	  @ResponseBody
	  @RequestMapping(value="/checkOutRegister", method= RequestMethod.POST) 
	  public String checkOutRegister(HttpServletRequest request){ 
		  
	  int bookid = Integer.parseInt(request.getParameter("bookID")); // å ���̵�
	  String userid = request.getParameter("userID"); // ����� ���̵�
	  checkOutDTO checkoutDto = new checkOutDTO(); 
	  checkoutDto.setBookID(bookid);
	  checkoutDto.setUserID(userid);
	  System.out.println("��������Դ�."+bookid);
	  System.out.println("��������Դ�."+userid);
	  List<CheckOutBean> check = checkoutDao.checkBookID(bookid); // �ߺ��Ǵ� bookID�� checkState  �ִ��� 
	  String message=null; 
	  if(check != null) { // ����� bookid�� �ֵ� = �����Ұ���
		  
		  message ="fail"; 
	  }
	  else {// �������� bookID�� ����
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
		 * Integer.parseInt(request.getParameter("bookID")); // å ���̵� String userid =
		 * request.getParameter("userID"); // ����� ���̵�
		 * 
		 * checkOutDTO checkoutDto = new checkOutDTO(); checkoutDto.setBookID(bookid);
		 * checkoutDto.setUserID(userid); System.out.println("��������Դ�."+bookid);
		 * System.out.println("��������Դ�."+userid);
		 * 
		 * checkoutDao.insertCheckOut(checkoutDto); }
		 */
	  
	// ���̵� ã�� Ŭ��
		@RequestMapping("/findid") //----------------�̰� �߰��߾��!!!!!
		public String findid() {
			return "findidView";
		}

		// ��й�ȣ ã�� Ŭ��
		@RequestMapping("/findpw") //----------------�̰� �߰��߾��!!!!!
		public String findpw() {
			return "findpwView";
		}

		// ��ȣ �����ϱ�
		@ResponseBody
		@RequestMapping(value="/send", method= RequestMethod.POST) //----------------�̰� �߰��߾��!!!!!
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

			// �Ʒ����� ���ڸ� ��¥ ������ ������, ������ �ÿ� �����ҋ� ����� ���̴�!!!!! �ּ� �����ϰų� �������� ������Ф�
			String api_key = "NCSHMNQ2F6RSPUR2";
		    String api_secret = "MHVTREMTC8IXI0HIR4QKOZLTVI9BKGSP";
		    Message coolsms = new Message(api_key, api_secret);
	
		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", "01092981199");
		    params.put("from", "01092981199");
		    params.put("type", "SMS");
		    params.put("text", "������ȣ�� "+ code +"�Դϴ�.");
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


		// ���̵� ã�� üũ
		@RequestMapping("/findidcheck") //
		public String findidcheck(HttpServletResponse response, Model model, User user) {
			String id = userDao.returnID(user);
			System.out.println("id------------"+id);

			response.setContentType("text/html; charset=UTF-8");
			if (id==null) {
				try {
					PrintWriter out = response.getWriter();

					out.println("<script>alert('�ش��ϴ� ������ �����ϴ�.'); </script>");
					out.flush();
					return "findidView";

				} catch (Exception e) {
					// TODO: handle exception
				}
			}else {
				try {
					PrintWriter out = response.getWriter();

					out.println("<script>alert('ã���� ���̵�� "+ id + "�Դϴ�.'); </script>");
					out.flush();
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			return "loginView";
		}

		// ��� ã�� üũ
		@RequestMapping("/findpwcheck")
		public String findpwcheck(HttpServletResponse response, Model model, User user) {
			String id = userDao.returnID(user);
			System.out.println("id------------"+id);

			response.setContentType("text/html; charset=UTF-8");
			if (id==null) {
				try {
					PrintWriter out = response.getWriter();

					out.println("<script>alert('�ش��ϴ� ������ �����ϴ�.'); </script>");
					out.flush();
					return "findpwView";

				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			model.addAttribute("idd", id);
			return "changePWView";
		}

		@RequestMapping("/changepwgo") //----------------�̰� �߰��߾��!!!!!
		public String changepwgo(HttpServletResponse response, User user) {
			System.out.println("������ ���̵� ���Դ�."+user.getUserID()+user.getUserPW());
			userDao.changePW(user);
			response.setContentType("text/html; charset=UTF-8");
			try {
				PrintWriter out = response.getWriter();
				out.println("<script>alert('��й�ȣ�� ����Ǿ����ϴ�.'); </script>");
				out.flush();
			} catch (Exception e) {
				// TODO: handle exception
			}
			return "loginView";
		}


	// ����------------------------------------------------------------------------------
	@RequestMapping("/notice")
	public String notice() {
		return "noticeView";
	}
	@RequestMapping("/mypage")
	public String mypage(Model model, String userID) {
		// session�� id ����
		// id �� user���̺� ��ȸ list
		// ����, �������̺��� ī���� int
		// view �������� ��� �����ֱ�
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
	
	//// ����------------------------------------------------------------------------------
	@RequestMapping("/introduce")
	public String introduce() {
		return "introduceView";
	}
	
	///����------------------------------------------------------------------------------
	@RequestMapping("/search")
	public String search() {
		return "searchView";
	}
	@RequestMapping("/bestBook")
	public String bestBook() {
		return "bestBookView";
	}
}
