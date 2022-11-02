require "test_helper"

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get game_new_url
    assert_response :success
  end

  test "should get start" do
    get game_start_url
    assert_response :success
  end

  test "should get load" do
    get game_load_url
    assert_response :success
  end

  test "should get switch" do
    get game_switch_url
    assert_response :success
  end

  test "should get block" do
    get game_block_url
    assert_response :success
  end

  test "should get throw" do
    get game_throw_url
    assert_response :success
  end
end
