require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  test "should get index," do
    sign_in users(:user_one)
    get :index
    assert_response :success
  end

  test "should create project" do
    sign_in users(:user_one)
    post :create
    assert_equal('Project was successufully created',flash["notice"],'wrong flash message')
    assert_response 302
  end

  test "should update project" do
    sign_in users(:user_one)
    patch :update, id: projects(:pr_one).id, project: {title: 'test'}
    assert_equal('Project was successufully updated',flash["notice"],'wrong flash message')
    assert_response 302
  end

  test "should delete project" do
    sign_in users(:user_one)
    delete :destroy, id: projects(:pr_one).id, project: {title: 'test'}
    assert_equal('Project was successufully deleted',flash["notice"],'wrong flash message')
    assert_response 302
  end
end
