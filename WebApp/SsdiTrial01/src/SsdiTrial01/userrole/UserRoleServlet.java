package SsdiTrial01.userrole;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import SsdiTrial01.beansclass.Discounts;
import SsdiTrial01.beansclass.Locations;



@WebServlet("/UserRoleServlet")
public class UserRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
            if(request.getContentType().equals("application/json")){
            	List<Discounts> discountlist = new ArrayList<Discounts>();
            	List<Locations> locationlist = new ArrayList<Locations>();
            	
            	 HttpSession session = request.getSession();
            	 if(session.getAttribute("discountlist")!=null){
            		 session.removeAttribute("discountlist");
            	 }

            	Gson gson = new Gson();
            	JsonParser parser = new JsonParser();
            	JsonArray dataarray = (JsonArray) parser.parse(request.getReader());
            	
            	System.out.println("data edit pressed " + dataarray.size());
            	
            	for(int i=0; i< dataarray.size();i++){
            		
            		JsonObject dataobject = (JsonObject) dataarray.get(i);
            		
            		if(dataobject.has("Price")){
            			
                    	Discounts discount = new Discounts();
                    	discount.setId(dataobject.get("Id").toString().replace("\"", "" ));
                    	discount.setRegionId(dataobject.get("RegionId").toString().replace("\"", "" ));
                    	discount.setOfferText(dataobject.get("OfferText").toString().replace("\"", "" ));
                    	discount.setPrice(dataobject.get("Price").toString().replace("\"", "" ));
                    	discount.setDiscountPercent(dataobject.get("DiscountPercent").toString().replace("\"", "" ));
                    	discount.setImageUrl(dataobject.get("ImageUrl").toString().replace("\"", "" ));
                    	discount.setRegionName(dataobject.get("RegionName").toString().replace("\"", "" ));
                    	discount.setBeaconId(dataobject.get("BeaconId").toString().replace("\"", "" ));
                    	discount.setStoreKeeperName(dataobject.get("StoreKeeperName").toString().replace("\"", "" ));
                    	discountlist.add(discount);
                    	
    					 
    				    session.setAttribute("discountlist",discountlist);
    				    
                
            		}
            		else{
            			
            			Locations location  = new Locations();
            			
            			location.setBeaconId(dataobject.get("BeaconId").toString().replace("\"", ""));
            			location.setRegionName(dataobject.get("RegionName").toString().replace("\"", ""));
            			location.setStorekeeperName(dataobject.get("StoreKeeperName").toString().replace("\"", ""));
            			location.setRegionId(dataobject.get("RegionId").toString().replace("\"", ""));
                        locationlist.add(location);
                        
                        session.setAttribute("locationlist",locationlist);
            		}
                
            	}
            	
            	System.out.println(" data array value : "  + discountlist);
            	PrintWriter out = response.getWriter();
                response.setContentType("text/html");
                response.setCharacterEncoding("UTF-8"); 
                out.write("success done changed bt");
                out.close();
            	  
            	
            	
            	
            	
            	
            }
		// TODO Auto-generated method stub
            else{
            	
           
			 String text = request.getParameter("param1");
			 
			
			 if(text.equals("userlogin")){
				 
				if(request.getParameter("userTokenValue")!=null){
					
					String usertokenvalue = request.getParameter("userTokenValue");
					 HttpSession session = request.getSession();
					 
					 session.setAttribute("tokenvalue","loggedin");
					 session.setAttribute("usertokenvalue",usertokenvalue);
					
				}
				 
                
				 
			 }
			 else if (text.equals("adminlogin")){ 
				 
				 HttpSession session = request.getSession();
				 
				 session.setAttribute("tokenvalue","loggedin");
		
			 }
			 else if(text.equals("loggedout")){
				 
				 HttpSession session = request.getSession();
				 session.removeAttribute("tokenvalue");
				 
	        	 session.setAttribute("tokenvalue","loggedout");
				 
			 }
			 else if(text.equals("userloggedout")){
				 
				 HttpSession session = request.getSession();
				 session.removeAttribute("tokenvalue");
				 
	        	 session.setAttribute("tokenvalue","userloggedout");
				 
			 }
			 
            }
			
		 }

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			// TODO Auto-generated method stub
			doPost(request,response);
		}

}
