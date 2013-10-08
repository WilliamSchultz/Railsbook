require 'test_helper'

class UserFriendshipDecoratorTest < Draper::TestCase
	context "#friendship_state" do
		context "with a pending user friendship" do 
		 	setup do 
				@user_friendship = create(:pending_user_friendship) 
				@decorator = UserFriendshipDecorator.decorate(@user_friendship)
			end 

			should "return Pending" do 
				assert_equal "Pending", @deorator.friendship_state
			 end
			end 

			 context "with an requested user friendship" do 
		 	setup do 
				@user_friendship = create(:requested_user_friendship) 
				@decorator = UserFriendshipDecorator.decorate(@user_friendship)
			end 

			should "return Requested" do 
				assert_equal "Requested", @deorator.friendship_state
			 end
		end 
	end 
end 

