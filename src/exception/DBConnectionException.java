package exception;

public class DBConnectionException extends RuntimeException {
   
	private static final long serialVersionUID = 1L;

	public DBConnectionException(String message, Throwable cause) {
        super(message, cause);
    }
}
