package Pack01;

import java.sql.Date;
import java.util.List;

public class CheckOutBean {
	int checkNum;
	String userID;
	int bookID;
	String ISBN;
	Date checkOutDate;
	Date checkInDate;
	String checkState;
	String reservationState;
	
	BookBean bookBean;
	
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
	public Date getCheckOutDate() {
		return checkOutDate;
	}
	public void setCheckOutDate(Date checkOutDate) {
		this.checkOutDate = checkOutDate;
	}
	public Date getCheckInDate() {
		return checkInDate;
	}
	public void setCheckInDate(Date checkInDate) {
		this.checkInDate = checkInDate;
	}
	public String getCheckState() {
		return checkState;
	}
	public void setCheckState(String checkState) {
		this.checkState = checkState;
	}
	public String getReservationState() {
		return reservationState;
	}
	public void setReservationState(String reservationState) {
		this.reservationState = reservationState;
	}
	public int getCheckNum() {
		return checkNum;
	}
	public void setCheckNum(int checkNum) {
		this.checkNum = checkNum;
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
		return "CheckOutBean [checkNum=" + checkNum + ", userID=" + userID + ", bookID=" + bookID + ", ISBN=" + ISBN
				+ ", checkOutDate=" + checkOutDate + ", checkInDate=" + checkInDate + ", checkState=" + checkState
				+ ", reservationState=" + reservationState + ", bookBean=" + bookBean + "]";
	}
	
	
	
	
}
