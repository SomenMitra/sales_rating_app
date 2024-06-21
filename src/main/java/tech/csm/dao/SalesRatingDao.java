package tech.csm.dao;

import java.util.List;
import java.util.Map;

public interface SalesRatingDao {

	String saveSales(Integer productId, Integer quantity, String rating);

	List<Map<String, Object>> getProductRatingByProductId(Integer prodId);

}
