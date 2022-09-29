package com.nppes.npiregistry.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonProcessingException;

@ControllerAdvice
public class GlobalExceptionHandler {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/**
	 * Handler class for UnprocessableEntityException
	 *
	 * @param exception the UnprocessableEntityException object as parameter
	 *
	 * @return the response entity.
	 *
	 * @throws JsonProcessingException
	 */
	@ExceptionHandler(value = UnprocessableEntityException.class)
	public ResponseEntity<?> handleUnprocessableEntityException(UnprocessableEntityException exception)
			throws JsonProcessingException {
		HttpStatusCodeErrorMessage forbiddenResponse = new HttpStatusCodeErrorMessage();
		logger.error("UnprocessableEntityException Occurred with Message:{}\n{}", exception.getMessage(), exception);
		if (exception.getMessage() != null && !exception.getMessage().isEmpty()) {
			forbiddenResponse.setMessage(exception.getMessage());
			return new ResponseEntity<>(forbiddenResponse, HttpStatus.UNPROCESSABLE_ENTITY);
		} else {
			return new ResponseEntity<>(HttpStatus.UNPROCESSABLE_ENTITY);
		}
	}

	/**
	 * Handler class for all other unhandily Exception
	 *
	 * @param exception the Exception object as parameter
	 *
	 * @return the response entity.
	 *
	 * @throws JsonProcessingException
	 */
	@ExceptionHandler(value = Exception.class)
	public ResponseEntity<?> handleGlobal(Exception exception) throws JsonProcessingException {
		HttpStatusCodeErrorMessage forbiddenResponse = new HttpStatusCodeErrorMessage();
		logger.error("Server is unable to process this request due to following error:{} exception:{}",
				exception.getMessage(), exception);
		forbiddenResponse.setMessage("Server is unable to process this request.");
		return new ResponseEntity<>(forbiddenResponse, HttpStatus.BAD_REQUEST);
	}

	/**
	 * Handler class for NotFoundException
	 *
	 * @param exception the NotFoundException object as parameter
	 *
	 * @return the response entity.
	 *
	 * @throws JsonProcessingException
	 */
	@ExceptionHandler(value = NotFoundException.class)
	public ResponseEntity<?> handleNotFoundException(NotFoundException exception) throws JsonProcessingException {
		HttpStatusCodeErrorMessage forbiddenResponse = new HttpStatusCodeErrorMessage();
		logger.error(exception.getMessage(), exception);
		if (exception.getMessage() != null && !exception.getMessage().isEmpty()) {
			forbiddenResponse.setMessage(exception.getMessage());
			return new ResponseEntity<>(forbiddenResponse, HttpStatus.NOT_FOUND);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

	/**
	 * HTTP status code handler class for all error type messages
	 */
	@JsonInclude(JsonInclude.Include.NON_NULL)
	class HttpStatusCodeErrorMessage {
		private String message;

		public String getMessage() {
			return message;
		}

		public void setMessage(String message) {
			this.message = message;
		}
	}

}
