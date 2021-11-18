package Pack01;

import java.sql.Date;

public class BookBean {
	String ISBN;
	int bookID;
	String img;
	String bookName;
	String author;
	String publisher;
	String checkOutState;
	String reservationState;
	Date registDate;
	String register;
	String detail;
	
	CheckOutBean checkOutBean;
	like like;
	
	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public like getLike() {
		return like;
	}
	public void setLike(like like) {
		this.like = like;
	}
	public int getBookID() {
		return bookID;
	}
	public void setBookID(int bookID) {
		this.bookID = bookID;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getCheckOutState() {
		return checkOutState;
	}
	public void setCheckOutState(String checkOutState) {
		this.checkOutState = checkOutState;
	}
	public String getReservationState() {
		return reservationState;
	}
	public void setReservationState(String reservationState) {
		this.reservationState = reservationState;
	}
	public Date getRegistDate() {
		return registDate;
	}
	public void setRegistDate(Date registDate) {
		this.registDate = registDate;
	}
	public String getRegister() {
		return register;
	}
	public void setRegister(String register) {
		this.register = register;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	
	public CheckOutBean getCheckOutBean() {
		return checkOutBean;
	}
	public void setCheckOutBean(CheckOutBean checkOutBean) {
		this.checkOutBean = checkOutBean;
	}
	

	
	

	
	
}
