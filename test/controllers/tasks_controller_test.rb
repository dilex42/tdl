require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  test "should create task" do
    sign_in users(:user_one)
    post :create, project_id: projects(:pr_one).id, task: {text: 'test'}
    assert_equal('Task was successufully created',flash["notice"],'wrong flash message')
    assert_response 302
  end

  test "should update task" do
    sign_in users(:user_one)
    patch :update, id: tasks(:task_one).id, project_id: projects(:pr_one).id, task: {text: 'test'}
    assert_equal('Task was successufully updated',flash["notice"],'wrong flash message')
    assert_response :success
  end

  test "should destroy task" do
    sign_in users(:user_one)
    delete :destroy, id: tasks(:task_two).id, project_id: projects(:pr_one).id
    assert_equal('Task was successufully deleted',flash["notice"],'wrong flash message')
    assert_response 302
  end

  test "should change priority up" do
    sign_in users(:user_one)
    get :priority, id: tasks(:task_two).id, project_id: projects(:pr_one).id, where: 'up'
    assert_equal('Success',flash["priority_up"],'wrong flash message')
    assert_equal('Success',flash["priority_down"],'wrong flash message')
    assert_response 302
  end 

  test "should change priority down" do
    sign_in users(:user_one)
    get :priority, id: tasks(:task_one).id, project_id: projects(:pr_one).id, where: 'down'
    assert_equal('Success',flash["priority_up"],'wrong flash message')
    assert_equal('Success',flash["priority_down"],'wrong flash message')
    assert_response 302
  end

  test "should change deadline" do
    sign_in users(:user_one)
    put :deadline, id: tasks(:task_one).id, project_id: projects(:pr_one).id, task: {deadline: '2014-08-14 14:57:20'} 
    assert_equal('Deadline was successufully updated',flash["notice"],'wrong flash message')
    assert_response 302
  end

  test "should mark task as done" do
    sign_in users(:user_one)
    get :done, id: tasks(:task_two).id, project_id: projects(:pr_one).id
    assert_equal('Task is done',flash["notice"],'wrong flash message')
    assert_response 302
  end

end
