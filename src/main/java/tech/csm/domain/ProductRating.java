package tech.csm.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class ProductRating implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2141806516610195694L;

	private Integer productRatingId;
	
	private Product product;
	
	private String rating;

}
