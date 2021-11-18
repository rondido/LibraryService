package Pack01;

import java.util.Date;
import java.util.List;

public class ReservationBean {
	int reserNum;
	String userID;
	int bookID;
	String ISBN;
	String reservationApply;
	String pickDate;
	String pickCheck;
	BookBean bookBean;
	
	public int getReserNum() {
		return reserNum;
	}
	public void setReserNum(int reserNum) {
		this.reserNum = reserNum;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getBookID() {
		return bookID;
	}
	public void setBookID(int bookID) {
		this.bookID = bookID;
	}
	public String getReservationApply() {
		return reservationApply;
	}
	public void setReservationApply(String reservationApply) {
		this.reservationApply = reservationApply;
	}
	

	public String getPickDate() {
		return pickDate;
	}
	public void setPickDate(String pickDate) {
		this.pickDate = pickDate;
	}
	public String getPickCheck() {
		return pickCheck;
	}
	public void setPickCheck(String pickCheck) {
		this.pickCheck = pickCheck;
	}

	public BookBean getBookBean() {
		return bookBean;
	}
	public void setBookBean(BookBean bookBean) {
		this.bookBean = bookBean;
	}
	

	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	@Override
	public String toString() {
		return "ReservationBean [reserNum=" + reserNum + ", userID=" + userID + ", bookID=" + bookID + ", ISBN=" + ISBN
				+ ", reservationApply=" + reservationApply + ", pickDate=" + pickDate + ", pickCheck=" + pickCheck
				+ ", bookBean=" + bookBean + "]";
	}
	
	
	
	
	
}