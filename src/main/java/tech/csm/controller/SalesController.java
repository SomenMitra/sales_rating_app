package tech.csm.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tech.csm.service.ProductService;
import tech.csm.service.SalesRatingService;

@Controller
public class SalesController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private SalesRatingService salesRatingService;

	@GetMapping("/getform")
	public String getform(Model model) {
				
		model.addAttribute("productList", productService.getAllProducts());
		return "sales";
	}
	
	@PostMapping("/save")
	public String saveData(@RequestParam() Integer productId, @RequestParam() Integer quantity, @RequestParam() String rating, RedirectAttributes rd) {

		rd.addFlashAttribute("msg", salesRatingService.saveSales(productId, quantity,rating));
		
		return "redirect:/getform";
	}
	
	@GetMapping("/fetchRatingsByProductId")
	public void getRatingData(@RequestParam() Integer prodId,
			HttpServletRequest req, HttpServletResponse resp) throws IOException {
		List<Map<String,Object>> ratingList=salesRatingService.getProductRatingByProductId(prodId);
		String rows="";
		for(Map<String,Object> data:ratingList) {
			rows+="<tr><td>"+data.get("rating")+"</td><td>"+data.get("total")+"</td></tr>";
		}
		resp.getWriter().println(rows);
	}
}



