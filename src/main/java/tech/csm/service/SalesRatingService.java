package tech.csm.service;

import java.util.List;
import java.util.Map;

public interface SalesRatingService {

	String saveSales(Integer productId, Integer quantity, String rating);

	List<Map<String, Object>> getProductRatingByProductId(Integer prodId);

}
