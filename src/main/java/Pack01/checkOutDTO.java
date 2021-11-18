package Pack01;

import java.sql.Date;

public class checkOutDTO {
	String userID;
	String ISBN;
	int bookID;
	Date checkOutDate;
	Date checkInDate;
	String checkState;
	String reservationState;
	
	public String getUserID() { return userID; }
	public void setUserID(String userID) { this.userID = userID; }

	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public int getBookID() { return bookID; }
	public void setBookID(int bookID) { this.bookID = bookID; }
	public Date getCheckOutDate() { return checkOutDate; }
	public void setCheckOutDate(Date checkOutDate) { this.checkOutDate = checkOutDate; }
	public Date getCheckInDate() { return checkInDate; }
	public void setCheckInDate(Date checkInDate) { this.checkInDate = checkInDate; }
	public String getCheckState() { return checkState; }
	public void setCheckState(String checkState) { this.checkState = checkState; }
	public String getReservationState() { return reservationState; }
	public void setReservationState(String reservationState) { this.reservationState = reservationState; }
	
}
