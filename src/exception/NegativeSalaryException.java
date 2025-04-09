package exception;

public class NegativeSalaryException extends RuntimeException {
    
	private static final long serialVersionUID = 1L;

	public NegativeSalaryException(String message) {
        super(message);
    }
}
