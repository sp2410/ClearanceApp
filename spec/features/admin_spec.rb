require "rails_helper"

#hey
describe "AdminPage"  do
    let!(:clearance_batch_1) { FactoryGirl.create(:clearance_batch) } 
    item1 = FactoryGirl.create(:item)
    style1 = FactoryGirl.create(:style)
           
    it "should allow admin to see staff performance" do            
            
            login_user_admin 
            visit "/"                                                                      
            expect(page).to have_link("Add/View Items")                           
            click_link "Add/View Items"            
            click_link "CREATE A NEW ITEM"
           
            fill_in "Barcode Id", :with => item1.id

            select item1.size, from: 'Size'
            fill_in "Color", :with => item1.color
            fill_in "Price Sold", :with => item1.price_sold

            select item1.status.to_s, :from => "Status"

            click_button "Submit"             

            visit "/"

            click_link("STAFF PERFORMANCE")  
            expect(page).to have_content("Items Processed By Staff")
            expect(page).to have_content("myname")
            
    end

    it "should allow admin to see activity" do
         
            login_user_admin 
            visit "/"                                                                      
            expect(page).to have_link("CREATE A BATCH")                           
            click_link "CREATE A BATCH"            
            click_button "Create new batch"
            expect(page).to have_content("New Batch Created")                               

            click_link("SEE ACTIVITY")  
            expect(page).to have_content("ALL ACTIVITIES")
            expect(page).to have_content("myname")
            expect(page).to have_content("admin")
            expect(page).to have_content("create")
            expect(page).to have_content("ClearanceBatch")            

    end

end