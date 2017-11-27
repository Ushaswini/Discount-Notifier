<!DOCTYPE html>
<html>
<head>
  <title>Admin</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/r/bs-3.3.5/jq-2.1.4,dt-1.10.8/datatables.min.css"/>  
  <script type="text/javascript" src="https://cdn.datatables.net/r/bs-3.3.5/jqc-1.11.3,dt-1.10.8/datatables.min.js"></script>
 
   <link rel="stylesheet" href="styles/admin.css" type="text/css"/>
  
</head>
     
<body onload="myFunction()">
     
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Admin Page</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="#">Home</a></li>
      <li><a id="goToManageLocations" href="#">Manage Locations</a></li>
    </ul>
    <button class="btn btn-danger navbar-btn" id = "logoutadmin" type="button" name = "action" value = "adminLogout">Logout</button>
  </div>
</nav>

    
    <div class="container">
  <h2>StoreKeeper Owner Data |  <a href="#"  class="btn btn-lg btn-primary" data-toggle="modal" data-target="#basicModal">Add shopkeeper</a></h2> 
  <br>    
  <table id="user-data-table" class="table table-striped">
    <thead>
      <tr>
        <th>RegionId</th>
        <th>StoreKeeper Owner</th>
        <th>Username</th>
      </tr>
    </thead>
    <tbody>
   
    </tbody>
  </table>
</div>

<!--  modal for add shopkeeper details  -->
<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title align" id="myModalLabel">ShopKeeper Details</h4>
    </div>
      
    <form action="" method="POST">
        <div class="modal-body">
           
                <div class="form-group">
                    <label>StoreKeeper Owner</label>
                    <input type="text" name="shopkeeperName" id="shopkeeperName" tabindex="1" class="form-control" placeholder="StoreKeeper Owner" value="">
               
                </div>
                
                 <div class="form-group">
                    <label>Location</label>
                    <select name="Location" class="form-control" id= "location">
                    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     				 <c:forEach items="${locationlist}" var="obj">
     				 <option>${obj.getRegionName()}</option>
                       
    				 </c:forEach>      
                    </select>
              
            </div>
            
            <div class="modal-header">
                   <h4 class="modal-title align" id="myModalLabel">Assign Login Details</h4>
           </div>
           
                 <div class="form-group">
                    <label>User name</label>
                   <input type="text" name="shopkeeperUserName" id="shopkeeperUserName" tabindex="1" class="form-control" placeholder="Shopkeeper Username" value="">
                </div>
                
                <div class="form-group">
                    <label>Email id</label>
                   <input type="Email" name="shopkeeperEmailid" id="shopkeeperEmailid" tabindex="1" class="form-control" placeholder="Shopkeeper Email Id" value="">
                </div>
                
                
                
                
                  <div class="form-group">
                    <label>Password</label>
                    <input type="text" name="shopkeeperPassword" id="shopkeeperPassword" tabindex="1" class="form-control" placeholder="Shopkeeper Password" value="">
                </div>
                 <div class="form-group">
                    <label>Confirm Password</label>
                    <input type="text" name="shopkeeperConfirmPassword" id="shopkeeperConfirmPassword" tabindex="1" class="form-control" placeholder="Confirm Password" value="">
                </div>
          
           
           
        </div>
        <div class="modal-footer">
            <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
            <button type="button" id = "addshopkeeper" class="btn btn-primary">Save Changes</button>
        </div>
    </form>
    </div>
  </div>
</div>

   


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
                    <label>Region Id</label>
                   <input type="text" name="addRegionRegionId" id="addRegionRegionId" tabindex="1" class="form-control" placeholder=" Region Id" value="">
                </div>
                  <div class="form-group">
                    <label>Region Name</label>
                   <input type="text" name="addRegionRegionName" id="addRegionRegionName" tabindex="1" class="form-control" placeholder="Enter Region Name" value="">
                </div>
                
                  <div class="form-group">
                    <label>Beacon ID </label>
                   <input type="text" name="addRegionBeaconId" id="addRegionBeaconId" tabindex="1" class="form-control" placeholder="Enter beacon Id" value="">
                </div>
                
                  <div class="form-group">
                    <label>StoreKeeper Name</label>
                   <input type="text" name="addRegionStoreKeeperName" id="addRegionStoreKeeperName" tabindex="1" class="form-control" placeholder=" Enter Storekeeper Name" value="">
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



</body>


<script>



  function  myFunction()  {

	      var logstatus = '<%= session.getAttribute("tokenvalue") %>';
	      if(logstatus==="loggedout"){
		        alert(" you have already logged out");
		       window.location.href='index.jsp';
	          }
        }
  
  
    $("#goToManageLocations").click(function(e){
    	
    	 window.location.href='Locations.jsp';
    	
    	
    });
     
    

     $('#logoutadmin').click(function(e) {
		  $.post(
		             "UserRoleServlet", 
		             {"param1" : "loggedout"}, 
		             function(result) {
		            	 window.location.href='index.jsp';
		   
		         });
		  

        });
     
    
  // Close the dropdown if the user clicks outside of it
     window.onclick = function(event) {
       if (!event.target.matches('.dropbtn')) {

         var dropdowns = document.getElementsByClassName("dropdown-content");
         var i;
         for (i = 0; i < dropdowns.length; i++) {
           var openDropdown = dropdowns[i];
           if (openDropdown.classList.contains('show')) {
             openDropdown.classList.remove('show');
           }
         }
       }
     }

     
     $(document).ready(function() {  
         $.ajax({  
             url: 'http://discountnotifier1.azurewebsites.net/api/Users/GetStoreKeepers',   
             type: 'GET',    
             dataType: 'json',  
             success: function(data, textStatus, xhr) {  
            	 //var datavalue = [data];
                 $('#user-data-table').DataTable({  
                	 data: data , 
                     columns :     [  
                    	 
                          {     "data"     :     "RegionId"     },  
                          {     "data"     :     "Name"},  
                          {     "data"     :     "Username"}  
                     ]  
                });  
                 
             },  
             error: function(xhr, textStatus, errorThrown) {  
                 console.log('Error in Database');  
                
             }  
         });  
     });  
     
     $('#addshopkeeper').click(function(e){
    	 
    	 console.log("entered here button");
			
			var shopkeeperusername = $('#shopkeeperUserName').val();
			var password  = $('#shopkeeperPassword').val();
			var regionid  = $('#location').val();
			var shopkeepername = $('#shopkeeperName').val();
			var shopkeeperEmail = $('#shopkeeperEmailid').val();
			var shopkeeperConfirmPassword =$('#shopkeeperConfirmPassword').val();
			
			var shopkeeperData = {
					username: shopkeeperusername,
					password: password,
					RegionId: regionid,
					Name: shopkeepername,
					Email:shopkeeperEmail,
					confirmpassword:shopkeeperConfirmPassword,
	            };
			
			console.log( " shopkeeper data " + shopkeeperData);
			
			
			$.ajax({
             type: 'POST',
             url: 'http://discountnotifier1.azurewebsites.net/api/Account/AddStoreKeeper',
             contentType: "application/json",
             dataType: "json",
             data: JSON.stringify(shopkeeperData),
         }).done(function (data) {
        	 
        	 window.location.reload();
        	 
        	 
         }).fail(function (error) { 
        	 window.location.reload();
        	 console.log("return error : " + JSON.stringify(error)) });

     });
     
     
 $('#addRegionConfirm').click(function(e){
    	 
    	 console.log("entered here add region");
			
			var addRegionRegionId = $('#addRegionRegionId').val();
			var addRegionRegionName  = $('#addRegionRegionName').val();
			var addRegionBeaconId  = $('#addRegionBeaconId').val();
			var addRegionStoreKeeperName = $('#addRegionStoreKeeperName').val();
		
			
			var addRegionData = {
					RegionId: addRegionRegionId,
					RegionName: addRegionRegionName,
					BeaconId: addRegionBeaconId,
					StoreKeeperName: addRegionStoreKeeperName,
				
	            };
			
			console.log( " add region  data " + addRegionData);
			
			
			$.ajax({
             type: 'POST',
             url: 'http://discountnotifier1.azurewebsites.net/api/Regions',
             contentType: "application/json",
             dataType: "json",
             data: JSON.stringify(addRegionData),
         }).done(function (data) {
        	 
        	 window.location.reload();
        	 
        	 
         }).fail(function (error) { 
        	 window.location.reload();
        	 console.log("return error : " + JSON.stringify(error)) });

     });
  
  
  
  
  </script>
  
</html>