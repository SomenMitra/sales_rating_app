<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cable TV Registration</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css" />
 
<script src="https://code.jquery.com/jquery-2.2.4.js"
	integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
	crossorigin="anonymous"></script>
<script
	src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
 
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


</head>

<body>
	<c:if test="${msg ne null}">
        <div class="alert alert-success" id="alId">${msg}</div>
    </c:if>
	<div class="container mt-4">

		<div class="container mt-2 text-center">
			<h3
				style="display: inline-block; animation: floatLeftToRight 10s linear infinite; white-space: nowrap; font-family: 'Pacifico', cursive; font-size: 3rem; color: #fff; background: linear-gradient(90deg, #a23cd1, #dd0d523f); padding: 2px 5px; border-radius: 6px; text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);">
				Sales Form</h3>
		</div>
		<form action="./save" method="POST" id="formId"
			enctype="multipart/form-data" onsubmit="return validateForm();">			
			<div class="row">
				<div class="col-3">
					<div>
						<label>Select Propduct</label> <select class="form-control"
							name="productId" id="productId" onchange="fetchRatingsByProductId()">
							<option value="0">--Select--</option>
							<c:forEach items="${productList}" var="prod">
								<option value="${prod.productId}">${prod.productName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-3">
					<div>
						<label>Quantity</label> <input type="text" class="form-control"
							name="quantity" id="quantityId">
					</div>
				</div>
				<div class="col-3">
					<div>
						<label>Rating</label> <select class="form-control"
							name="rating" id="ratingId"
							onchange="getEmpByBatchAndTechId()">
							<option value="0">--Select--</option>
							<option value="1 Star">1 Star</option>
							<option value="2 Star">2 Star</option>
							<option value="3 Star">3 Star</option>
							<option value="4 Star">4 Star</option>
							<option value="5 Star">5 Star</option>
							
						</select>
					</div>
				</div>
				
				<div class="col-3">
					<div class="card mt-4">
					<div class="card-body">
						<table class="table table-bordered" id="vTableId">
							
							<thead>
								<tr>
									<!-- <th>Sl No</th> -->
									<th>Rating</th>
									<th>Total #</th>
									

								</tr>
							</thead>
							<tbody id= "tblId">
								
							</tbody>
						</table>
					</div>
				</div>
				</div>
				
			</div>
			<div class="row mt-3 justify-content-center">
				<div class="col-md-6 text-center">
					<button type="submit" class="btn btn-primary">Submit</button>
					<button type="reset" class="btn btn-secondary">Reset</button>
				</div>
			</div>
		</form>
		
			
	
	

	<script type="text/javascript">
	
	 $(document).ready(function() {
		 
         setTimeout(function(){
       	  document.getElementById("alId").style.display='none';
         },5000);
       }); 
	 
	/*  $(function() {
			$("#vTableId").dataTable({
				"lengthMenu" : [ 3, 5, 10, 15, "All" ]
			});
		});  */
	
	
	function fetchRatingsByProductId() {
			
			var productId = $("#productId").val();	
			 var selectedProductName = $("#productId option:selected").text();
			$.ajax({
				url : 'fetchRatingsByProductId',
				type : "GET",
				data : {
					prodId: productId
				},
				success : function(data) {

					$('#tblId').html(data);
				},

				error : function(error) {
					console.log(`Error ${error}`);
				}
			});
		}

		function validateForm() {
		    var productId = $("#productId").val();
		    var quantityId = $("#quantityId").val();
		    var ratingId = $("#ratingId").val();
		    

		    if (productId == '0') {
		        alert("Please select the product !");
		        $("#productId").focus();
		        return false;
		    }
		    
		    if (quantityId.trim() == '') {
		        alert("Please enter the Quantity !");
		        $("#quantityId").focus();
		        return false;
		    }
		    
		    if (ratingId == '0') {
		        alert("Please select the rating !");
		        $("#ratingId").focus();
		        return false;
		    }
		   
		    return true;
		}
		
		
		 
	</script>
</body>
</html>