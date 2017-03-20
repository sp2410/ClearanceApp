require "rails_helper"
#hey
describe "app backbone" do

    describe "main link" do 
        it "should bring you to home page" do 
            login_user_staff
            visit "/"
            expect(page).to have_link("Stitch Fix Clearance Tool")
            click_link("Stitch Fix Clearance Tool")       
            expect(page).to have_link("CREATE A BATCH")
            expect(page).to have_current_path(root_path)
        end
    end

    describe "see previous clearance batches" do

      let!(:clearance_batch_1) { FactoryGirl.create(:clearance_batch) }
      let!(:clearance_batch_2) { FactoryGirl.create(:clearance_batch) }

      #Passed
      it "displays a list of all past clearance batches" do
        visit "/"
        expect(page).to have_content("Stitch Fix Clearance Tool")
        expect(page).to have_content("CLEARANCE BATCHES")        
        expect(page).to have_content("Clearance Batch #{clearance_batch_1.id}")
        expect(page).to have_content("Clearance Batch #{clearance_batch_2.id}")        
        expect(page).to have_content("Item Count")        
        expect(page).to have_content("Created at")        
        expect(page).to have_link("Add/View Items")       

      end
      #Passed
      it "displays links to sign up sign in and root page" do
        visit "/"       

        expect(page).to have_link("SIGN IN")
        expect(page).to have_link("SIGN IN")
        expect(page).to have_link("Stitch Fix Clearance Tool")
        expect(page).to have_field("search")
        expect(page).to have_field("searchitem")
      end

    end
   

    describe "add a new clearance batch" do
        let!(:clearance_batch_1) { FactoryGirl.create(:clearance_batch) }     
        context "total success" do
        #Passed
            it "should allow a staff user to add a new clearance batch successfully" do

              login_user_staff
              visit "/"                                                                       

              expect(page).to have_link("CREATE A BATCH")              
              expect(page).to have_link("MY ACCOUNT")
              click_link "CREATE A BATCH"

              expect(page).to have_current_path("/clearance_batches/new")                            
              expect(page).to have_button('Create new batch')
              click_button "Create new batch"
              
              expect(page).to have_content("New Batch Created")
              expect(page).to have_content("Created at")
              expect(page).to have_content("Clearance Batch 1")
              expect(page).to have_content("Item Count")

              expect(page).to have_link("Add/View Items")
              expect(page).to have_link("Delete Batch")
              expect(page).to have_content("TO BE SOLD")                           
            end

            it "should not allow a vendor user to add a new clearance batch " do                        
            #passed
              login_user_vendor
              visit "/"                                                                       

              expect(page).to have_no_link("CREATE A BATCH")              
              expect(page).to have_link("MY ACCOUNT")              

              expect(page).to have_link("Add/View Items")
              expect(page).to have_no_link("Delete Batch")
              expect(page).to have_link("BUY BATCH")                           
            end

            it "should allow a admin user to add a new clearance batch successfully" do
            #passed
              login_user_admin
              visit "/"                                                                       

              expect(page).to have_link("CREATE A BATCH")              
              expect(page).to have_link("MY ACCOUNT")
              click_link "CREATE A BATCH"

              expect(page).to have_current_path("/clearance_batches/new")                            
              expect(page).to have_button('Create new batch')
              click_button "Create new batch"
              
              expect(page).to have_content("New Batch Created")
              expect(page).to have_content("Created at")
              expect(page).to have_content("Clearance Batch 1")
              expect(page).to have_content("Item Count")

              expect(page).to have_link("Add/View Items")
              expect(page).to have_link("Delete Batch")
              expect(page).to have_content("TO BE SOLD")                           
            end
        end
    end


    describe "delete a newly created clearance batch" do      
        let!(:clearance_batch_1) { FactoryGirl.create(:clearance_batch) }  
           
        it "should allow a staff user to delete a batch" do            
            login_user_staff          

            visit "/"                                                                      
            expect(page).to have_link("Delete Batch")                            
            click_link "Delete Batch"
            driver.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError            
            expect(page).to have_content("Batch Deleted")
            expect(page).to have_no_content("Clearance Batch #{clearance_batch_1.id}")
                  
        end  

        it "should not allow a vendor user to delete a batch" do            
            login_user_vendor         

            visit "/"                                                                     
            expect(page).to have_no_link("Delete Batch")                   
        end 

        it "should allow an admin user to delete a batch" do            
            login_user_admin         

            visit "/"                                                                      
            expect(page).to have_link("Delete Batch")                            
            click_link "Delete Batch"
            driver.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError            
            expect(page).to have_content("Batch Deleted")
            expect(page).to have_no_content("Clearance Batch #{clearance_batch_1.id}")                  
        end
    end

    describe "Add Items To A Batch" do      
        let!(:clearance_batch_1) { FactoryGirl.create(:clearance_batch) }  
        item1 = FactoryGirl.create(:item)
        item2 = FactoryGirl.create(:item)
        style1 = FactoryGirl.create(:style)
        
        it "should allow a signed-in user type staff to add items to a batch" do            
            
            login_user_staff
            visit "/"                                                                      
            expect(page).to have_link("Add/View Items")                           
            click_link "Add/View Items"
            
            expect(page).to have_content("CLEARANCE BATCH NUMBER #{clearance_batch_1.id}")
            expect(page).to have_link("CREATE A NEW ITEM")
            click_link "CREATE A NEW ITEM"

            expect(page).to have_content("Enter Item Details")
            expect(page).to have_content("Barcode Id")
            expect(page).to have_content("Size")
            expect(page).to have_content("Color")

            fill_in "Barcode Id", :with => item1.id

            select item1.size, from: 'Size'
            fill_in "Color", :with => item1.color
            fill_in "Price Sold", :with => item1.price_sold


            select item1.status.to_s, :from => "Status"

             click_button "Submit"
             expect(page).to have_content("Item was successfully created.")
             expect(page).to have_content(item1.color.to_s)
             expect(page).to have_content(item1.status.to_s)
             expect(page).to have_content(item1.price_sold.to_s)             
             expect(page).to have_content("Clearance Batch id: 1")
             expect(page).to have_content("Created At")                          
             expect(page).to have_content("Updated At")                          
                          
        end  

         it "should not allow vendors to add items to a batch" do            
            
            login_user_vendor
            visit "/"                                                                      
            expect(page).to have_link("Add/View Items")                           
            click_link "Add/View Items"
            
            expect(page).to have_content("CLEARANCE BATCH NUMBER #{clearance_batch_1.id}")
            expect(page).to have_no_link("CREATE A NEW ITEM")            
                        
                          
        end    

        it "should allow a signed-in user type admin to add items to a batch" do            
            
            login_user_admin
            visit "/"                                                                      
            expect(page).to have_link("Add/View Items")                           
            click_link "Add/View Items"
            
            expect(page).to have_content("CLEARANCE BATCH NUMBER #{clearance_batch_1.id}")
            expect(page).to have_link("CREATE A NEW ITEM")
            click_link "CREATE A NEW ITEM"

            expect(page).to have_content("Enter Item Details")
            expect(page).to have_content("Barcode Id")
            expect(page).to have_content("Size")
            expect(page).to have_content("Color")

            fill_in "Barcode Id", :with => item1.id

            select item1.size, from: 'Size'
            fill_in "Color", :with => item1.color
            fill_in "Price Sold", :with => item1.price_sold


            select item1.status.to_s, :from => "Status"

             click_button "Submit"
             expect(page).to have_content("Item was successfully created.")
             expect(page).to have_content(item1.color.to_s)
             expect(page).to have_content(item1.status.to_s)
             expect(page).to have_content(item1.price_sold.to_s)             
             expect(page).to have_content("Clearance Batch id: 1")
             expect(page).to have_content("Created At")                          
             expect(page).to have_content("Updated At")                          
        end              
    end

    describe "Edit Items" do      
        let!(:clearance_batch_1) { FactoryGirl.create(:clearance_batch) }  
        item1 = FactoryGirl.create(:item)        
        #style1 = FactoryGirl.create(:style)

         it "should allow a staff user to edit items" do            
            
            login_user_staff            
            visit "/"                                                                      
            expect(page).to have_link("Add/View Items")                           
            click_link "Add/View Items"
            
            expect(page).to have_content("CLEARANCE BATCH NUMBER #{clearance_batch_1.id}")
            expect(page).to have_link("CREATE A NEW ITEM")
            click_link "CREATE A NEW ITEM"

            expect(page).to have_content("Enter Item Details")
            expect(page).to have_content("Barcode Id")
            expect(page).to have_content("Size")
            expect(page).to have_content("Color")

            fill_in "Barcode Id", :with => item1.id

            select item1.size, from: 'Size'
            fill_in "Color", :with => item1.color
            fill_in "Price Sold", :with => item1.price_sold


            select item1.status.to_s, :from => "Status"

            click_button "Submit"            

            expect(page).to have_link("Edit")
            expect(page).to have_link("Show")

            click_link "Edit" 

            expect(page).to have_content("Edit Item Details")            
                          
        end 

        it "should now allow same barcode item to be inserted again" do            
            
            login_user_staff            
            visit "/"                                                                      
            expect(page).to have_link("Add/View Items")                           
            click_link "Add/View Items"
            
            expect(page).to have_content("CLEARANCE BATCH NUMBER #{clearance_batch_1.id}")
            expect(page).to have_link("CREATE A NEW ITEM")
            click_link "CREATE A NEW ITEM"

            fill_in "Barcode Id", :with => item1.id

            select item1.size, from: 'Size'
            fill_in "Color", :with => item1.color
            fill_in "Price Sold", :with => item1.price_sold

            select item1.status.to_s, :from => "Status"

            click_button "Submit" 

            #Repeat The same process

            click_link "CREATE A NEW ITEM"

            fill_in "Barcode Id", :with => item1.id

            select item1.size, from: 'Size'
            fill_in "Color", :with => item1.color
            fill_in "Price Sold", :with => item1.price_sold

            select item1.status.to_s, :from => "Status"

            click_button "Submit"   

            expect(page).to have_content("error prohibited this item from being saved")                                  
        end 

        it "should allow a admin user to edit items" do            
            
            login_user_admin            
            visit "/"                                                                      
            expect(page).to have_link("Add/View Items")                           
            click_link "Add/View Items"
            
            expect(page).to have_content("CLEARANCE BATCH NUMBER #{clearance_batch_1.id}")
            expect(page).to have_link("CREATE A NEW ITEM")
            click_link "CREATE A NEW ITEM"

            expect(page).to have_content("Enter Item Details")
            expect(page).to have_content("Barcode Id")
            expect(page).to have_content("Size")
            expect(page).to have_content("Color")

            fill_in "Barcode Id", :with => item1.id

            select item1.size, from: 'Size'
            fill_in "Color", :with => item1.color
            fill_in "Price Sold", :with => item1.price_sold


            select item1.status.to_s, :from => "Status"

            click_button "Submit"            

            expect(page).to have_link("Edit")
            expect(page).to have_link("Show")

            click_link "Edit" 

            expect(page).to have_content("Edit Item Details")            
                          
        end 

        it "should not allow a vendor user to edit items" do            
            
            login_user_vendor            
            visit "/"                                                                      
            expect(page).to have_link("Add/View Items")                           
            click_link "Add/View Items"
            
            expect(page).to have_content("CLEARANCE BATCH NUMBER #{clearance_batch_1.id}")
            expect(page).to have_no_link("CREATE A NEW ITEM")            
        end
    end  
end






