package tech.csm.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class Sales implements Serializable {
	
	private Integer salesId;
	
	private Date salesDate;
	
	private Product product;
	
	private Integer quantity;

}
