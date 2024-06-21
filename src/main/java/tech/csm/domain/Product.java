package tech.csm.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class Product implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7879120686148828131L;

	private Integer productId;
	
	private String productName;
	
	private Integer quantity;
	
	private Double unitPrice;

}
