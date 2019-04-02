require "application_system_test_case"

class ActiveStorageBlobsTest < ApplicationSystemTestCase
  setup do
    @active_storage_blob = active_storage_blobs(:one)
  end

  test "visiting the index" do
    visit active_storage_blobs_url
    assert_selector "h1", text: "Active Storage Blobs"
  end

  test "creating a Active storage blob" do
    visit active_storage_blobs_url
    click_on "New Active Storage Blob"

    fill_in "Blob", with: @active_storage_blob.blob
    click_on "Create Active storage blob"

    assert_text "Active storage blob was successfully created"
    click_on "Back"
  end

  test "updating a Active storage blob" do
    visit active_storage_blobs_url
    click_on "Edit", match: :first

    fill_in "Blob", with: @active_storage_blob.blob
    click_on "Update Active storage blob"

    assert_text "Active storage blob was successfully updated"
    click_on "Back"
  end

  test "destroying a Active storage blob" do
    visit active_storage_blobs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Active storage blob was successfully destroyed"
  end
end
