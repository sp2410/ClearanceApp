require "rails_helper"
#hey
 describe "search" do      
        let!(:clearance_batch_1) { FactoryGirl.create(:clearance_batch) }          
        item1 = FactoryGirl.create(:item) 


        it "should allow a user to search a batch" do            
            login_user_staff            
            visit "/"                                 

            
            click_link "CREATE A BATCH"
            click_button "Create new batch"
            visit "/"   
            click_link "CREATE A BATCH"
            click_button "Create new batch"
            visit "/"   

            fill_in "search", :with => clearance_batch_1.id.to_i+1
            click_button("Search Batch", match: :first)
            expect(page).to have_content("Clearance Batch #{(clearance_batch_1.id.to_i+1)}")
        end 

        it "should allow a user to search am item" do            
            login_user_staff            
            visit "/"                                 
        
            click_link("Add/View Items", match: :first)
                        
            click_link "CREATE A NEW ITEM"

            fill_in "Barcode Id", :with => "22"

            select item1.size, from: 'Size'
            fill_in "Color", :with => item1.color
            fill_in "Price Sold", :with => item1.price_sold

            select item1.status.to_s, :from => "Status"

            click_button "Submit" 

            visit "/"   

            fill_in "searchitem", :with => "2"
            click_button("Search Item", match: :first)
            expect(page).to have_content("barcode ID: 22")
        end
end 