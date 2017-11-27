<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>StoreKeeper</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
 <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.7/css/jquery.dataTables.css">
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/tabletools/2.2.3/css/dataTables.tableTools.css">
 
    <script type="text/javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="//cdn.datatables.net/1.10.7/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="//cdn.datatables.net/tabletools/2.2.3/js/dataTables.tableTools.min.js"></script>
    <script type="text/javascript" src="//cdn.datatables.net/plug-ins/380cb78f450/integration/bootstrap/3/dataTables.bootstrap.js"></script>
    <script type="text/javascript" src="js/dataTables.editor.js"></script>
 
  <link rel="stylesheet" href="styles/storekeeper.css" type="text/css"/>
</head>
<body onload="myFunction()" >

<div class="container">
	<div class="row">
		<div class="row">
				<div class="callout-dark text-center fade-in-b">
					<h1>Hello ${discountlist.get(0).getStoreKeeperName() } |   <a href="#"  id = "user-logout" class="btn btn-danger"> Logout </a></h1>
				<p> There are too many retailers. There are too many brands. There are too many companies. </p>
				            <p> But only the discounts on the products make people happy. So make them count </p> 
				</div>
			</div>
			
  
		<div class="col-xs-12">
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">
						<div class="row">
							<div class="col-xs-6">
								<h3><span class="glyphicon glyphicon-scissors"></span>  Offer Description   <a href="#" id = "addDiscount" class="btn  btn-info" data-toggle="modal" data-target="#addDiscountmodal"> Add Discounts</a> </h3>
							</div>                                                                       
						</div>
					</div>
				</div>
				<div class="panel-body"> 
				
				
				<table class="table table-striped">
   					
   					 <tbody>
  					  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     					 <c:forEach items="${discountlist}" var="obj">
       					 <tr id = "testrow">
       					    
       					     
       					      
       					     	<td>
									<div class="media">
										<a href="#" class="pull-left">
											<img src="${obj.getImageUrl()}" alt = "discount image " class="media-photo">
											<input  id = "imageurl" type = "hidden" value="${obj.getImageUrl()}" >
								    	</a>
											<div class="media-body">
											<h4 class="title">${obj.getOfferText()}</h4>
											<input  id = "offertext" type = "hidden" value="${obj.getOfferText()}" >
											
											<p  class="summary">offer price : ${obj.getPrice()}$</p>
											<input  id = "price" type = "hidden" value="${obj.getPrice()}" >
											
											<p class="summary">discount : ${obj.getDiscountPercent()}%</p>
											<input  id = "discountpercent" type = "hidden" value="${obj.getDiscountPercent()}" >
											
											<input  id = "id" type = "hidden" value="${obj.getId()}" >
											<input  id = "regionid" type = "hidden" value="${obj.getRegionId()}" >
											<input  id = "regionname" type = "hidden" value="${obj.getRegionName()}" >
											<input  id = "beaconid" type = "hidden" value="${obj.getBeaconId()}" >
											<input  id = "storekeepername" type = "hidden" value="${obj.getStoreKeeperName()}" >
											
											
											
											
											
										</div>
									</div>
								</td>
								<td><a href="#" id = "edit-button" class="btn btn-lg btn-success padding" data-toggle="modal" data-target="#basicModal">edit</a></td>
								<td><a href="#" id = "delete-button" class="btn btn-lg btn-danger padding" data-toggle="modal" data-target="#deletemodal">Delete</a></td>
						
     					      </tr>
   					     </c:forEach>
                                    					 
       			
    				</tbody>
  					</table>
  					
  					
  	<!--  modal for edit  button popup -->
  	
  		<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
          <div class="modal-dialog">
         <div class="modal-content">
          <div class="modal-header">
       		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
       			 <h4 class="modal-title align" id="myModalLabel">Edit discount details</h4>
    	</div>
      
    <form action="" method="POST">
        <div class="modal-body">
        
                 <div class="form-group">
                   
                    <img src="" id="imageurlPopup" class="img-responsive center-block"  alt="discount image">
                </div>
        
        
                
           
                <div class="form-group">
                    <label>Offer Text</label>
                    <input type="text" name="offertextPopup" id="offertextPopup" tabindex="1" class="form-control" placeholder= "" value="">
                    <input  id = "editDiscountId" type = "hidden" value="" >
               
                </div>
                <div class="form-group">
                    <label>Price </label>
                    <input type="text" name="pricePopup" id="pricePopup" tabindex="1" class="form-control" placeholder= "" value="">
               
                </div>
                <div class="form-group">
                    <label>Discount percent</label>
                    <input type="text" name="discountpercentPopup" id="discountpercentPopup" tabindex="1" class="form-control" placeholder= "" value="">
               
                </div>
                
                 </div>
        <div class="modal-footer">
            <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
            <button type="button" id = "changeDiscount" class="btn btn-primary">Update Discount</button>
        </div>
    </form>
                
				
				
				</div>
		</div>
	</div>
	
	
	<!--  modal for delete button popup -->
	
	<div class="modal fade" id="deletemodal" tabindex="-1" role="dialog" aria-labelledby="deletemodal" aria-hidden="true">
          <div class="modal-dialog">
         <div class="modal-content">
          <div class="modal-header">
       		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
       			 <h4 class="modal-title align" id="mydeleteModalLabel">Delete selected Discount</h4>
    	</div>
      
    <form action="" method="POST">
        <div class="modal-body">
        
                 <div class="form-group">
                    <img src="" id="deleteImageurlPopup" class="img-responsive center-block"  alt="Cinque Terre">
                </div>
                <div class="form-group">
                    <label>Offer Text</label>
                    <div class="well well-sm"><span id="DeleteOffertextPopup"  class="form-control"></span ></div>
                    <input  id = "deleteDiscountId" type = "hidden" value="" >
                </div>
                
          <div class="modal-footer">
            <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
            <button type="button" id = "deleteDiscount" class="btn btn-primary">delete Discount</button>
        </div>
        </div>
    </form>
                
				
				
	</div>
	</div>
	</div>
		
	
<!--  modal for add discounts button popup -->

<div class="modal fade" id="addDiscountmodal" tabindex="-1" role="dialog" aria-labelledby="addDiscountmodal" aria-hidden="true">
          <div class="modal-dialog">
         <div class="modal-content">
          <div class="modal-header">
       		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
       			 <h4 class="modal-title align" id="myAddDiscountModalLabel">Add a Discount</h4>
    	</div>
      
    <form action="" method="POST">
        <div class="modal-body">
        
               <div class="form-group">
                    <label>Offer Text</label>
                   <input type="text" name="addDiscountOfferText" id="addDiscountOfferText" tabindex="1" class="form-control" placeholder=" offer text" value="">
                </div>
                  <div class="form-group">
                    <label>price</label>
                   <input type="text" name="addDiscountprice" id="addDiscountprice" tabindex="1" class="form-control" placeholder="enter price value" value="">
                </div>
                
                  <div class="form-group">
                    <label>Discount Percent </label>
                   <input type="text" name="addDiscountDiscountPercent" id="addDiscountDiscountPercent" tabindex="1" class="form-control" placeholder="enter discount percent" value="">
                </div>
                
                  <div class="form-group">
                    <label>image Url</label>
                   <input type="text" name="addDiscountImageUrl" id="addDiscountImageUrl" tabindex="1" class="form-control" placeholder=" enter image url" value="">
                </div>
                
          <div class="modal-footer">
            <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
            <button type="button" id = "addDiscountconfirm" class="btn btn-primary">Add Discount</button>
        </div>
        </div>
    </form>
                
				
				
	</div>
	</div>
	</div>
	
	
	</div>
	</div>
	</div>
	</div>
	</div>
	

</body>

<script type="text/javascript">



function  myFunction()  {
	
	console.log( "random number " + generateUUID ());

    var logstatus = '<%= session.getAttribute("tokenvalue") %>';
    if(logstatus==="userloggedout"){
	        alert(" you have already logged out");
	       window.location.href='index.jsp';
        }
    else{
    	window.location.reload();
    	//startup();
    }
  }

$('#user-logout').click(function(e) {
	  $.post(
	             "UserRoleServlet", 
	             {"param1" : "userloggedout"}, 
	             function(result) {
	            	 window.location.href='index.jsp';
	   
	         });
	  

  });
  
$(document).on('click', '#edit-button', function(){ 
	
	 var currentRow=$(this).closest("tr");
	 var colOffertext =currentRow.find("#offertext").val();
	 var colPrice =currentRow.find("#price").val();
	 var colDiscountpercent =currentRow.find("#discountpercent").val();
	 var colimageurl =currentRow.find("#imageurl").val();
	 var colIdValue = currentRow.find("#id").val();
	 
	 
    
     document.getElementById("offertextPopup").value = colOffertext;
     document.getElementById("pricePopup").value = colPrice;
     document.getElementById("discountpercentPopup").value = colDiscountpercent;
     document.getElementById("imageurlPopup").src = colimageurl;
      document.getElementById("editDiscountId").value = colIdValue;

     
     console.log("id value to be edited = " + colIdValue );
     
     
     //document.getElementById("shopkeeperName").innerHTML = col2;
     
	 }); 
	 
$(document).on('click', '#delete-button', function(){ 
	
	 var currentRow=$(this).closest("tr");
	 var colOffertext =currentRow.find("#offertext").val();
	 var colimageurl =currentRow.find("#imageurl").val();
	 var colIdValue = currentRow.find("#id").val();
	 
	 
   
   
    $("#DeleteOffertextPopup").text(colOffertext);
    document.getElementById("deleteImageurlPopup").src = colimageurl;
    
    document.getElementById("deleteDiscountId").value = colIdValue;
    
    console.log("id value to be deletd = " + colIdValue );
    
    
    //document.getElementById("shopkeeperName").innerHTML = col2;
    
	 }); 
	 
window.onload = function () {
    if (! localStorage.justOnce) {
        localStorage.setItem("justOnce", "true");
        window.location.reload();
    }
}

var refreshvalue = 0;  
  
var regionIdofUser;

$(document).ready(startup);
    
 function startup(){
	 
	// get user info with token passing
		var userTokenValue = '<%= session.getAttribute("usertokenvalue") %>';
	    $.ajax({  
	        url: 'http://discountnotifier1.azurewebsites.net/api/Account/UserInfo?token='+userTokenValue,   
	        type: 'GET',    
	        dataType: 'json',  
	        success: function(data, textStatus, xhr) {  
	        	// if that user token passsing succeeds, we get user info
	        	// get discounts by id 
	        	 regionIdofUser = data.RegionId;
	        	
	        	 $.ajax({  
	                 url: 'http://discountnotifier1.azurewebsites.net/api/Discounts?regionId='+regionIdofUser,   
	                 type: 'GET',    
	                 dataType: 'json',  
	                 success: function(data, textStatus, xhr) {  
	                     //send data to servelt
	                	 $.ajax({
	                		    url: "${pageContext.request.contextPath}/UserRoleServlet",
	                		    data: JSON.stringify(data),
	                		    type:'POST',
	                		    contentType: "application/json",
	                		    //dataType : 'json',  
	                		    success:function(response,textStatus,xhr){
	                		
	                		    	console.log("enetred success only" + refreshvalue);
	                		    	if(refreshvalue === 1){
	                		    		console.log("enetred success only" + refreshvalue);
	                		    		window.location.reload();
	                		    	}
	                		    	
	                		    
	                		    },
	                		    error:function(textStatus, xhr){

	                		        console.log('Service call failed!' + JSON.stringify(textStatus));
	                		        if(refreshvalue === 1){
	                		    		console.log("enetred success only" + refreshvalue);
	                		    		window.location.reload();
	                		    	}
	                		    }
	                		    
	                		    
	                		});
	   
	                 },  
	                 error: function(xhr, textStatus, errorThrown) {  
	                     console.log('Error in Database');  
	                    
	                 }  
	             });  
	   
	        },  
	        error: function(xhr, textStatus, errorThrown) {  
	            console.log('Error in Database');  
	           
	        }  
	    });  
	 
	 
	 
	 
 }
    
    
$('#addDiscountconfirm').click(function(e){
	 
	 console.log("entered here discount add confirm");
		
		var addDiscountOfferText = $('#addDiscountOfferText').val();
		var addDiscountprice = $('#addDiscountprice').val();
		var addDiscountDiscountPercent = $('#addDiscountDiscountPercent').val();
		var addDiscountImageUrl = $('#addDiscountImageUrl').val();
	    var randomIdValue =  Math.floor(100000 + Math.random() * 900000);
	    var stringidvalue = randomIdValue.toString();
	    
	    console.log(" redion id of user = " + regionIdofUser)
		
		
		var addDiscountData = {
				Id: stringidvalue,
				RegionId: regionIdofUser,
				OfferText: addDiscountOfferText,
				Price: addDiscountprice,
				DiscountPercent: addDiscountDiscountPercent,
				ImageUrl: addDiscountImageUrl,
          };
		
	   console.log( " discount data " + JSON.stringify(addDiscountData));
		
		
		$.ajax({
       type: 'POST',
       url: 'http://discountnotifier1.azurewebsites.net/api/Discounts',
       contentType: "application/json",
       dataType: "json",
       data: JSON.stringify(addDiscountData),
   }).done(function (data) {
  
  	refreshvalue = 1;
    startup();
  
   }).fail(function (error) { console.log("return error : " + JSON.stringify(error)) });

});
    
    
$('#changeDiscount').click(function(e){
	 
	 console.log("entered here discount update");
		
		var idValue = $('#editDiscountId').val();
		var regionidValue = $('#regionid').val();
		var offertextValue = $('#offertextPopup').val();
		var priceValue = $('#pricePopup').val();
		var discountPercentValue = $('#discountpercentPopup').val();
		var imageurlValue = $('#imageurlPopup').src;
		
		
		
		var discountData = {
				id: idValue,
				regionid: regionidValue,
				offertext: offertextValue,
				price: priceValue,
				discountpercent: discountPercentValue,
				imageurl: imageurlValue,
           };
		
		console.log( " shopkeeper data " + JSON.stringify(discountData));
		
		
		$.ajax({
        type: 'PUT',
        url: 'http://discountnotifier1.azurewebsites.net/api/Discounts/'+idValue,
        contentType: "application/json",
        dataType: "json",
        data: JSON.stringify(discountData),
    }).done(function (data) {
    	
    	console.log( " edited shopkeeper data " + JSON.stringify(data));
    	 console.log("enetered edit sucees");
  	   refreshvalue = 1;
  	   startup();
  	   
        
    }).fail(function (error) {
    	
    	
    });

});


$('#deleteDiscount').click(function(e){
	 
	 console.log("entered here discount delete");
		
		var idValue = $('#deleteDiscountId').val();
		$.ajax({
       type: 'DELETE',
       url: 'http://discountnotifier1.azurewebsites.net/api/Discounts/'+idValue,
       
   }).done(function (data) {
	   
	   console.log("enetered delete sucees");
	   refreshvalue = 1;
	   startup();
	   
	   // startup();
   }).fail(function (error) {
	   
	  
	   console.log("return error : " + JSON.stringify(error))
	   
   });

});


//generate random uuid

function generateUUID () { 
    var d = new Date().getTime();
    if (typeof performance !== 'undefined' && typeof performance.now === 'function'){
        d += performance.now();
    }
    return 'xxxxx4xyxxxy'.replace(/[xy]/g, function (c) {
        var r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
}


    


</script>
</html>