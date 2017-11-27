<!DOCTYPE html>
<html>
<head>
  <title>Manage Locations</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   <link rel="stylesheet" href="styles/admin.css" type="text/css"/>
  
</head>
     
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Admin Page</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a id="goToAdminHomePage" href="#">Home</a></li>
    </ul>
    <button class="btn btn-danger navbar-btn" id = "logoutadmin" type="button" name = "action" value = "adminLogout">Logout</button>
  </div>
</nav>

 
    <div class="container">
  <h2> beacon-Id linked to locations  |  <a href="#" class="btn btn-lg btn-primary" data-toggle="modal" data-target="#addRegionModal">Add Region</a></h2> 
  <br>  
  
  <!--  table to display locations with beacon id -->  
 	<table class="table table-striped">
 	       <thead>
     			 <tr>
       				 <th>Region Name</th>
       				 <th>StoreKeeper Owner</th>
       				 <th>Beacon Id</th>
     			 </tr>
   			 </thead>
   					
   					 <tbody>
  					  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     					 <c:forEach items="${locationlist}" var="obj">
       			           <tr id = "testrow">
       			     			<td>${obj.getRegionName()}
       			     			<input  id = "LocationRegionid" type = "hidden" value="${obj.getRegionId()}" >
       			     			<input  id = "LocationRegionName" type = "hidden" value="${obj.getRegionName()}" >
       			     			</td>
       							<td>${obj.getStorekeeperName()}
       							  <input  id = "LocationStorekeepername" type = "hidden" value="${obj.getStorekeeperName()}" >
       							</td>
      							 <td>${obj.getBeaconId()}
      							 <input  id = "LocationBeaconid" type = "hidden" value="${obj.getBeaconId()}" >
      							 </td>
								<td><a href="#" id = "Locationedit-button" class="btn btn-lg btn-success padding" data-toggle="modal" data-target="#editRegionModal">edit</a></td>
								<td><a href="#" id = "Locationdelete-button" class="btn btn-lg btn-danger padding" data-toggle="modal" data-target="#Regiondeletemodal">Delete</a></td>
						        
     			 			 </tr>
   					     </c:forEach>
                                    					 
       			
    				</tbody>
  					</table>
  					
  
<!--  modal for add region button popup -->

<div class="modal fade" id="addRegionModal" tabindex="-1" role="dialog" aria-labelledby="addRegionModal" aria-hidden="true">
          <div class="modal-dialog">
         <div class="modal-content">
          <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
             <h4 class="modal-title align" id="addRegionModalLabel">Add a Region</h4>
      </div>
      
    <form action="" method="POST">
        <div class="modal-body">
        
               
                  <div class="form-group">
                    <label>Region Name</label>
                   <input type="text" name="addRegionRegionName" id="addRegionRegionName" tabindex="1" class="form-control" placeholder="enter Region Name" value="">
                </div>
                
                  <div class="form-group">
                    <label>Beacon ID </label>
                   <input type="text" name="addRegionBeaconId" id="addRegionBeaconId" tabindex="1" class="form-control" placeholder="enter beacon Id" value="">
                </div>
                
                  <div class="form-group">
                    <label>StoreKeeper Name</label>
                   <input type="text" name="addRegionStoreKeeperName" id="addRegionStoreKeeperName" tabindex="1" class="form-control" placeholder=" enter Storekeeper Name" value="">
                </div>
                
          <div class="modal-footer">
            <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
            <button type="button" id = "addRegionConfirm" class="btn btn-primary">Add Region</button>
        </div>
        </div>
    </form>
                
        
        
  </div>
  </div>
  </div>
  
  
  <!--  modal for edit  region button popup -->

<div class="modal fade" id="editRegionModal" tabindex="-1" role="dialog" aria-labelledby="editRegionModal" aria-hidden="true">
          <div class="modal-dialog">
         <div class="modal-content">
          <div class="modal-header">
           <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
             <h4 class="modal-title align" id="addRegionModalLabel">Edit a Region</h4>
      </div>
      
    <form action="" method="POST">
        <div class="modal-body">
        
               
                  <div class="form-group">
                    <label>Region Name</label>
                   <input type="text" name="editRegionRegionName" id="editRegionRegionName" tabindex="1" class="form-control"  value="">
                   <input  id = "editregionRegionId" type = "hidden" value="" >
                </div>
                
                  <div class="form-group">
                    <label>Beacon ID </label>
                   <input type="text" name="editRegionBeaconId" id="editRegionBeaconId" tabindex="1" class="form-control" value="">
                </div>
                
                  <div class="form-group">
                    <label>StoreKeeper Owner</label>
                   <input type="text" name="editRegionStoreKeeperName" id="editRegionStoreKeeperName" tabindex="1" class="form-control" value="">
                </div>
                
          <div class="modal-footer">
            <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
            <button type="button" id = "editRegionConfirm" class="btn btn-primary">Edit Region</button>
        </div>
        </div>
    </form>
                
        
        
  </div>
  </div>
  </div>
  
  
  <!--  modal for delete button popup -->
	
	<div class="modal fade" id="Regiondeletemodal" tabindex="-1" role="dialog" aria-labelledby="Regiondeletemodal" aria-hidden="true">
          <div class="modal-dialog">
         <div class="modal-content">
          <div class="modal-header">
       		 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
       			 <h4 class="modal-title align" id="mydeleteModalLabel">Delete selected Region</h4>
    	</div>
      
    <form action="" method="POST">
        <div class="modal-body">
        
                <div class="form-group">
                    <label>Region Name</label>
                    <div class="well well-sm"><span id="DeleteRegionNamePopup"  class="form-control"></span ></div>
                    <input  id = "deleteRegionId" type = "hidden" value="" >
                </div>
                
          <div class="modal-footer">
            <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
            <button type="button" id = "deleteRegionConfirm" class="btn btn-primary">delete Region</button>
        </div>
        </div>
    </form>
                
				
				
	</div>
	</div>
	</div>
		
  
  
</div>



</body>

<script>

$("#goToAdminHomePage").click(function(e){
	
	 window.location.href='admin.jsp';
	
	
});

$('#logoutadmin').click(function(e) {
	  $.post(
	             "UserRoleServlet", 
	             {"param1" : "loggedout"}, 
	             function(result) {
	            	 window.location.href='index.jsp';
	   
	         });
	  

  });
  
var refreshvalue = 0;
$(document).ready(startup);

function startup(){
	 
	// get user info with token passing
		var userTokenValue = '<%= session.getAttribute("usertokenvalue") %>';
	    $.ajax({  
	        url: 'http://discountnotifier1.azurewebsites.net/api/Regions',   
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
           		
           		    	console.log("enetred success add region from servlet only" + JSON.stringify(response));
           		    	if(refreshvalue === 1){
           		    		console.log("enetred success add region only" + refreshvalue);
           		    		window.location.reload();
           		    	}
           		    	
           		    
           		    },
           		    error:function(textStatus, xhr){

           		        console.log('Service call failed! add region' + JSON.stringify(textStatus));
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
	 
	 
	 
	 
}

window.onload = function () {
    if (! localStorage.justOnce) {
        localStorage.setItem("justOnce", "true");
        window.location.reload();
    }
}

$(document).on('click', '#Locationedit-button', function(){ 
	
	 var currentRow=$(this).closest("tr");
	 var LocationRegionName =currentRow.find("#LocationRegionName").val();
	 var LocationRegionid =currentRow.find("#LocationRegionid").val();
	 var LocationStorekeepername =currentRow.find("#LocationStorekeepername").val();
	 var LocationBeaconid =currentRow.find("#LocationBeaconid").val();
	
	 
	 
   
    document.getElementById("editRegionRegionName").value = LocationRegionName;
    document.getElementById("editregionRegionId").value = LocationRegionid;
    document.getElementById("editRegionBeaconId").value = LocationBeaconid;
    document.getElementById("editRegionStoreKeeperName").value = LocationStorekeepername;

    
    console.log("id value to be edited = " + LocationRegionid );
   
    
	 }); 
	 
$(document).on('click', '#Locationdelete-button', function(){ 
	
	 var currentRow=$(this).closest("tr");
	 var LocationRegionid =currentRow.find("#LocationRegionid").val();
	 var LocationRegionName =currentRow.find("#LocationRegionName").val();
	

   $("#DeleteRegionNamePopup").text(LocationRegionName);
   
   document.getElementById("deleteRegionId").value = LocationRegionid;
   
   console.log("region id value to be deletd = " + LocationRegionid );
   
   
 
	 }); 
   
  
$('#addRegionConfirm').click(function(e){
  
   var addRegionRegionName  = $('#addRegionRegionName').val();
   var addRegionBeaconId  = $('#addRegionBeaconId').val();
   var addRegionStoreKeeperName = $('#addRegionStoreKeeperName').val();
 
   
   var addRegionData = {
      
       RegionName: addRegionRegionName,
       BeaconId: addRegionBeaconId,
       StoreKeeperName: addRegionStoreKeeperName,
     
           };

   $.ajax({
          type: 'POST',
          url: 'http://discountnotifier1.azurewebsites.net/api/Regions',
          contentType: "application/json",
          dataType: "json",
          data: JSON.stringify(addRegionData),
      }).done(function (data) {
     
    	  console.log("region data: " + JSON.stringify(data));
    	  refreshvalue = 1;
    	  startup();
        
      }).fail(function (error) { 
        window.location.reload();
        console.log("return error : " + JSON.stringify(error)) });

  });
  
  
$('#editRegionConfirm').click(function(e){
    
    console.log("entered here edit region");
   
  
   var editRegionRegionName  = $('#editRegionRegionName').val();
   var editRegionBeaconId  = $('#editRegionBeaconId').val();
   var editRegionStoreKeeperName = $('#editRegionStoreKeeperName').val();
   var editregionRegionId = $('#editregionRegionId').val();
 
   
   var editRegionData = {
	   RegionId : editregionRegionId,
       RegionName: editRegionRegionName,
       BeaconId: editRegionBeaconId,
       StoreKeeperName: editRegionStoreKeeperName,
     
           };
 
   $.ajax({
          type: 'PUT',
          url: 'http://discountnotifier1.azurewebsites.net/api/Regions/'+editregionRegionId,
          contentType: "application/json",
          data: JSON.stringify(editRegionData),
      }).done(function (data) {
        
    	  console.log("region data: " + JSON.stringify(data));
    	  refreshvalue = 1;
    	  startup();
        
      }).fail(function (error) { 
     
        console.log("return error : " + JSON.stringify(error)) });

  });
  
  
  //delete region
  
  $('#deleteRegionConfirm').click(function(e){
	 
	 console.log("entered here region confirm delete");
		
		var deleteRegionidValue = $('#deleteRegionId').val();
		$.ajax({
       type: 'DELETE',
       url: 'http://discountnotifier1.azurewebsites.net/api/Regions/'+deleteRegionidValue,
       
   }).done(function (data) {

	   refreshvalue = 1;
	   startup();
	   
   }).fail(function (error) {

	   console.log("return error : " + JSON.stringify(error))
	   
   });

});
  
 

</script>
</html>