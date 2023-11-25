require "test_helper"

class MicroTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get micro_templates_new_url
    assert_response :success
  end

  test "should get create" do
    get micro_templates_create_url
    assert_response :success
  end

  test "should get edit" do
    get micro_templates_edit_url
    assert_response :success
  end

  test "should get update" do
    get micro_templates_update_url
    assert_response :success
  end
end
