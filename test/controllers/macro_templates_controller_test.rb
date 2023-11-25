require "test_helper"

class MacroTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get macro_templates_new_url
    assert_response :success
  end

  test "should get create" do
    get macro_templates_create_url
    assert_response :success
  end

  test "should get edit" do
    get macro_templates_edit_url
    assert_response :success
  end

  test "should get update" do
    get macro_templates_update_url
    assert_response :success
  end
end
