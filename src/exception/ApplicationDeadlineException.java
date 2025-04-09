package exception;

public class ApplicationDeadlineException extends RuntimeException {
    
	private static final long serialVersionUID = 1L;

	public ApplicationDeadlineException(String message) {
        super(message);
    }
}