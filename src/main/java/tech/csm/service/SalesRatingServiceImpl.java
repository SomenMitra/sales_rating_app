package tech.csm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tech.csm.dao.SalesRatingDao;

@Service
public class SalesRatingServiceImpl implements SalesRatingService {
	
	@Autowired
	private SalesRatingDao salesRatingDao;

	@Override
	public String saveSales(Integer productId, Integer quantity, String rating) {

		return salesRatingDao.saveSales(productId,quantity,rating);
	}

	@Override
	public List<Map<String, Object>> getProductRatingByProductId(Integer prodId) {
		
		return salesRatingDao.getProductRatingByProductId( prodId);
	}

	

}
