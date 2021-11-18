package Pack01;

public class AdminBookDto {
	String ISBN;
	int bookID;
	String bookName;
	String author;
	String publisher;
	String checkOutState;
	String reservationState;
	String registDate;
	String register;
	String detail;

	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public int getBookID() {
		return bookID;
	}
	public void setBookID(int bookID) {
		this.bookID = bookID;
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
	public String getRegistDate() {
		return registDate;
	}
	public void setRegistDate(String registDate) {
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
	
	
}
