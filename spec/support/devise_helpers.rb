#module for authenticating users for request specks
module ValidUserRequestHelper
	
	def login_user_staff
		@user ||= FactoryGirl.create(:user, role: 'staff')
		page.driver.post user_session_path, :user => {:email => @user.email, :password => @user.password}
	end
	def login_user_admin
		@user ||= FactoryGirl.create(:user, role: 'admin')
		page.driver.post user_session_path, :user => {:email => @user.email, :password => @user.password}
	end
	def login_user_vendor
		@user ||= FactoryGirl.create(:user, role: 'vendor')
		page.driver.post user_session_path, :user => {:email => @user.email, :password => @user.password}
	end
end