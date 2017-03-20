require "rails_helper"
#hey

describe "VendorPage"  do
    let!(:clearance_batch_1) { FactoryGirl.create(:clearance_batch) } 
    item1 = FactoryGirl.create(:item)

    it "should allow vendors to buy an item" do
    	login_user_vendor 
    	visit "/"               
        click_link("BUY BATCH")  
        expect(page).to have_content("You Bought Batch Number #{clearance_batch_1.id} ")
    end

    it "should allow vendors to access their account" do
    	login_user_vendor 
    	visit "/"                       
        expect(page).to have_link("MY ACCOUNT")
    end

    it "should show vendors their batches"  do
    	login_user_vendor 
    	visit "/"          
    	click_link("BUY BATCH")     
    	expect(page).to have_link("MY BATCHES") 
        click_link("MY BATCHES")  
        expect(page).to have_current_path(mybatches_path)
        expect(page).to have_content("MY BATCHES")
        expect(page).to have_content("Clearance Batch #{clearance_batch_1.id}")
    end

    it "should show vendors their batches with all no sellable item "  do
    	 login_user_vendor 
    	 visit "/"          
    	 click_link("BUY BATCH")     
    	 expect(page).to have_link("MY BATCHES") 
         click_link("MY BATCHES")  
         expect(page).to have_current_path(mybatches_path)
         expect(page).to have_content("MY BATCHES")
         expect(page).to have_no_content("sellable")
    end
end