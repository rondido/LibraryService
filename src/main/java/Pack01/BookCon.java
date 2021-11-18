package Pack01;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import DTO.BookSearchDTO;



@Controller
public class BookCon {
	BookSearchDAO dao = new BookSearchDAO();
	
	@RequestMapping("/bookSearch")
	public void totalSearch(HttpServletRequest request, HttpServletResponse response, BookSearchDTO dto) {
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			System.out.println(dto.getSearchItem());
			System.out.println(dto.getSearchText());
			response.getWriter().write(dao.getJSON(dto));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("/bookSearch2")
	public String totalSearch2(Model model,HttpServletRequest request, HttpServletResponse response, BookSearchDTO dto) {
		
		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			System.out.println(dto.getSearchItem());
			System.out.println(dto.getSearchText());
			response.getWriter().write(dao.getJSON(dto));
			
			model.addAttribute("searchText",dto.getSearchText());
			model.addAttribute("searchItem",dto.getSearchItem());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "indexSearchView";
	}

}
