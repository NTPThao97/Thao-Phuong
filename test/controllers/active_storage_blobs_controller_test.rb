require 'test_helper'

class ActiveStorageBlobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @active_storage_blob = active_storage_blobs(:one)
  end

  test "should get index" do
    get active_storage_blobs_url
    assert_response :success
  end

  test "should get new" do
    get new_active_storage_blob_url
    assert_response :success
  end

  test "should create active_storage_blob" do
    assert_difference('ActiveStorageBlob.count') do
      post active_storage_blobs_url, params: { active_storage_blob: { blob: @active_storage_blob.blob } }
    end

    assert_redirected_to active_storage_blob_url(ActiveStorageBlob.last)
  end

  test "should show active_storage_blob" do
    get active_storage_blob_url(@active_storage_blob)
    assert_response :success
  end

  test "should get edit" do
    get edit_active_storage_blob_url(@active_storage_blob)
    assert_response :success
  end

  test "should update active_storage_blob" do
    patch active_storage_blob_url(@active_storage_blob), params: { active_storage_blob: { blob: @active_storage_blob.blob } }
    assert_redirected_to active_storage_blob_url(@active_storage_blob)
  end

  test "should destroy active_storage_blob" do
    assert_difference('ActiveStorageBlob.count', -1) do
      delete active_storage_blob_url(@active_storage_blob)
    end

    assert_redirected_to active_storage_blobs_url
  end
end
