# frozen_string_literal: true

require 'test_helper'

class PathologistsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get pathologists_index_url
    assert_response :success
  end

  test 'should get show' do
    get pathologists_show_url
    assert_response :success
  end

  test 'should get new' do
    get pathologists_new_url
    assert_response :success
  end

  test 'should get create' do
    get pathologists_create_url
    assert_response :success
  end

  test 'should get edit' do
    get pathologists_edit_url
    assert_response :success
  end

  test 'should get update' do
    get pathologists_update_url
    assert_response :success
  end

  test 'should get destroy' do
    get pathologists_destroy_url
    assert_response :success
  end
end
