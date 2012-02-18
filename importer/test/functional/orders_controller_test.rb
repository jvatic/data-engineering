require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  test "#new is success" do
    get :new
    assert_response :success
  end

  test "uploading data file creates Order" do
    @data_file = fixture_file_upload('example_input.tab')
    @data_file.class_eval { attr_reader :tempfile }
    assert_difference("Order.count", 2) do
      post :import, :orders => { :data_file => @data_file }
    end
  end

  test "not providing data file redirects back to #new with error message" do
    post :import
    assert_redirected_to :action => :new
    assert !flash[:error].blank?
  end

end
