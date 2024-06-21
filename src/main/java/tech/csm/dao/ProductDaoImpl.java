package tech.csm.dao;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import tech.csm.domain.Product;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private DataSource dataSource;
	
	@Override
	public List<Product> getAllProducts() {
		SimpleJdbcCall simpleJdbcCall = new SimpleJdbcCall(dataSource).withProcedureName("sales_app_proc").returningResultSet("allProducts", new BeanPropertyRowMapper<>(Product.class));
		Map<String, Object> products = simpleJdbcCall.execute("seProd", Types.NULL, Types.NULL, Types.NULL);
		List<Product> productList = (List<Product>) products.get("allProducts");
		return productList;
	}

}
