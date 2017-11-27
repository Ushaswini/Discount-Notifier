<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <title>login page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script type = "text/javascript" src ="js/jquery-3.2.1.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
  <link rel="stylesheet" href="styles/loginpage.css" type="text/css"/>
</head>
<body>


<div class="container">
        
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col-xs-6">
								<a href="#" class="active" id="admin-login-link">Admin</a>
							</div>
							<div class="col-xs-6">
								<a href="#" id="shopkeeper-login-link">StoreKeeper</a>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">


								<form id="admin-login" action = "UserRoleServlet" role="form" style="display: block;">
									<div class="form-group">
										<input type="text" name="username" id="adminUsername" tabindex="1" class="form-control" placeholder="Username" value="">
									</div>
									<div class="form-group">
										<input type="password" name="password" id="adminPassword" tabindex="2" class="form-control" placeholder="Password">
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<button  type = "button" name = "action" value="adminLogin" id="admin-login-submit" tabindex="4" class="form-control btn btn-admin-login">Login</button>
											</div>
										</div>
									</div>
								</form>


								<form id="shopkeeper-login"  role="form" style="display: none;">
									<div class="form-group">
										<input type="text" name="username" id="shopkeeperUsername" tabindex="1" class="form-control" placeholder="Username" value="">
									</div>
									<div class="form-group">
										<input type="password" name="password" id="shopkeeperPassword" tabindex="2" class="form-control" placeholder="Password">
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<button type="button" name="action"  value="shopkeeperLogin" id="shopkeeper-login-submit" tabindex="4" class="form-control btn btn-shopkeeper-login">Log in </button>
											</div>
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



</body>

 <script >
  
  $(document).ready(function() {

	    $('#admin-login-link').click(function(e) {
	    	
	    	console.log("enbetred action");
	    	 
	    
			$("#admin-login").delay(100).fadeIn(100);
	 		$("#shopkeeper-login").fadeOut(100);
			$('#shopkeeper-login-link').removeClass('active');
			$(this).addClass('active');
			e.preventDefault();
		});
		$('#shopkeeper-login-link').click(function(e) {
			$("#shopkeeper-login").delay(100).fadeIn(100);
	 		$("#admin-login").fadeOut(100);
			$('#admin-login-link').removeClass('active');
			$(this).addClass('active');
			e.preventDefault();
		});
		
		$('#admin-login-submit').click(function(e) {
			
			console.log("entered here button");
			
			var adminUsername = $('#adminUsername').val();
			var password  = $('#adminPassword').val();
			
			var loginData = {
	                grant_type: 'password',
	                username: adminUsername,
	                password: password,
	            
	            };
			
			console.log("login data " + loginData);
			console.log(password);
			
			$.ajax({
                type: 'POST',
                url: 'http://careme-surveypart2.azurewebsites.net/oauth2/token',
                data: loginData
            }).done(function (data) {
            	
            	 $.post(
    		             "UserRoleServlet", 
    		             {"param1" : "adminlogin"}, 
    		             function(result) {
    		            	 window.location.href='admin.jsp';
    		   
    		         });
  
                 	
    
            	  
            }).fail(function (error) { console.log(error) });
  
      });

	
  
  $('#shopkeeper-login-submit').click(function(e) {
		
		console.log("entered here button");
		
		var shopkeeperUsername = $('#shopkeeperUsername').val();
		var shopkeeperPassword  = $('#shopkeeperPassword').val();
		
		var loginData = {
              grant_type: 'password',
              username: shopkeeperUsername,
              password: shopkeeperPassword,
          
          };
		
		console.log("login data " + loginData);
		
		$.ajax({
          type: 'POST',
          url: 'http://discountnotifier1.azurewebsites.net/oauth2/token',
          data: loginData
      }).done(function (data) {
    	  console.log("user data value : " + JSON.stringify(data))
    	  $.post(
		             "UserRoleServlet", 
		             {"param1" : "userlogin",
		               "userTokenValue" : data.access_token,
		               },
		             
		             function(result) {
		            	 
		            	 window.location.href='storekeeper.jsp';
		   
		         });
		  
      	  
      }).fail(function (error) { console.log("shopkeep error " + JSON.stringify(error)) });

   });

   });



  
  </script>
</html>