require "test_helper"

class DiagnosisTemplatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get diagnosis_templates_new_url
    assert_response :success
  end

  test "should get create" do
    get diagnosis_templates_create_url
    assert_response :success
  end

  test "should get edit" do
    get diagnosis_templates_edit_url
    assert_response :success
  end

  test "should get update" do
    get diagnosis_templates_update_url
    assert_response :success
  end
end
