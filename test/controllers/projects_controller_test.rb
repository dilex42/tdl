require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  test "should get index," do
    get :index,
    assert_response :success
  end

  test "should get create,update" do
    get :create,update
    assert_response :success
  end

end
