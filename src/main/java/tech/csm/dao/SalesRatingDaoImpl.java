package tech.csm.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

@Repository
public class SalesRatingDaoImpl implements SalesRatingDao {
	
	@Autowired
	private DataSource dataSource;

	@Override
	public String saveSales(Integer productId, Integer quantity, String rating) {
		SimpleJdbcCall jdbcCall = new SimpleJdbcCall(dataSource).withProcedureName("sales_app_proc");
		Map<String, Object> res= jdbcCall.execute("insales", productId, quantity, rating);
		
		return  (String) res.get("p_msg");
	}

	@Override
	public List<Map<String, Object>> getProductRatingByProductId(Integer prodId) {
		SimpleJdbcCall jdbcCall = new SimpleJdbcCall(dataSource)
	            .withProcedureName("sales_app_proc")
	            .returningResultSet("ratingData", new RowMapper<Map<String, Object>>() {

	                @Override
	                public Map<String, Object> mapRow(ResultSet rs, int rowNum) throws SQLException {
	                    // Create a map to hold each row's data
	                    Map<String, Object> dataMap = new HashMap<>();
	                    dataMap.put("rating", rs.getString(1)); // Use column names instead of indexes
	                    dataMap.put("total", rs.getString(2));	                    
	                    return dataMap;
	                }
	            });

	    Map<String, Object> data = jdbcCall.execute("setable",prodId, Types.NULL,Types.NULL);

	    List<Map<String, Object>> ratingReport = (List<Map<String, Object>>) data.get("ratingData");

	    return ratingReport;
	}

	

}
