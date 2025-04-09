package exception;

public class ResumeUploadException extends RuntimeException {
    
	private static final long serialVersionUID = 1L;

	public ResumeUploadException(String message) {
        super(message);
    }
}
