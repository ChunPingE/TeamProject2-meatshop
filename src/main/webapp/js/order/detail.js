	
$("#paymentButton").click(function() {
	  
	var data = [];
	
	$("table tbody tr").each(function() {
		var row = $(this);
		var quantity = row.find("#quantity").val();
		var productId = row.find("#productId").val();
        var price = row.find("#price").val();
        var fromCart = row.find("#fromCart").val();
        
        data.push({
			quantity: quantity,
			productId: productId,
			price: price,
			fromCart: fromCart
		});
	});
	
	$.ajax({
        url: "/order/payed",
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json",
        success: function(response) {
          console.log(response);
          window.location.href = "/order/success"; // 완료되면 주문완료 화면 보여주기
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.log(textStatus, errorThrown);

        }
  	});
  	
});