require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "should not save project without logged user" do
    project = Project.new
    project.title ='teat'
    assert_not project.save, "Saved the project without a user"
  end

  test "should not save project without title" do
    project = Project.new
    assert_not project.save, "Saved the project without a title"
  end
end
