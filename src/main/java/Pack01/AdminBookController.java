package Pack01;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Request;
import org.apache.ibatis.session.SqlSession;
import org.apache.maven.plugin.lifecycle.Phase;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class AdminBookController {
	AdminBookDao dao = new AdminBookDao();
	@RequestMapping("/adminbooksearch")
	public void totalSearch(HttpServletRequest request, HttpServletResponse response, BookSearchDTO dto) {
		try {
			System.out.println(dto.getSearchItem());
			System.out.println(dto.getSearchText());
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().write(dao.getJSON(dto));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/bookjoin")
	public String insert(AdminBookDto dto) {
		dao.insert(dto);
		return "/"; 
	}
	@RequestMapping("/adminUpdate")
	public String select(HttpServletRequest request, Model model) {
		int id = Integer.parseInt(request.getParameter("bookID")) ;
		System.out.println(id);
		
		List<AdminBookDto> mm = dao.select1(id);
		model.addAttribute("mm",mm);
		return "adminUpdateView"; 
	}
	
	@RequestMapping("/adminPage")
	public String adminPage() {
		return "adminPageView"; 
	}
	
	@RequestMapping("/apiMain")
	   public String apiMain(BookBean bookbean, HttpServletRequest request){
	      try {
	         System.out.println("apiMain 진입");
	         System.out.println(bookbean.getAuthor()); // bean에 담아서 데이터 잘 너어옴!!
	         System.out.println(bookbean.getISBN()); // bean에 담아서 데이터 잘 너어옴!!
	         dao.bookRegist(bookbean);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return "adminPageView";
	   }
	
	  @RequestMapping("/banap")
	   public String banap(HttpServletRequest request){
	      try {
	    	  	System.out.println(request.getParameter("bookID2"));
	    	  	int bookID = Integer.parseInt(request.getParameter("bookID2"));
	    	  	dao.banap(bookID);
	    	  
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return "redirect:/goCheck";
	   }
	  @RequestMapping("/goCheck")
	   public String goCheck(){
		  
		  
		  return "borrowView";
		  
	  }
	
}
