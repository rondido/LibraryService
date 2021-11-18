package Pack01;

public class like {
	String userID;
	String ISBN;
	BookBean bookBean;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	
	
	public String getISBN() {
		return ISBN;
	}
	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}
	public BookBean getBookBean() {
		return bookBean;
	}
	public void setBookBean(BookBean bookBean) {
		this.bookBean = bookBean;
	}
	@Override
	public String toString() {
		return "like [userID=" + userID + ", ISBN=" + ISBN + ", bookBean=" + bookBean + "]";
	}
	
	
	
	
	
}
