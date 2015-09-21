require 'test_helper'

class WikiracesControllerTest < ActionController::TestCase
  setup do
    @wikirace = wikiraces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wikiraces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wikirace" do
    assert_difference('Wikirace.count') do
      post :create, wikirace: { end: @wikirace.end, end_description: @wikirace.end_description, racedate: @wikirace.racedate, start: @wikirace.start, start_description: @wikirace.start_description }
    end

    assert_redirected_to wikirace_path(assigns(:wikirace))
  end

  test "should show wikirace" do
    get :show, id: @wikirace
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wikirace
    assert_response :success
  end

  test "should update wikirace" do
    patch :update, id: @wikirace, wikirace: { end: @wikirace.end, end_description: @wikirace.end_description, racedate: @wikirace.racedate, start: @wikirace.start, start_description: @wikirace.start_description }
    assert_redirected_to wikirace_path(assigns(:wikirace))
  end

  test "should destroy wikirace" do
    assert_difference('Wikirace.count', -1) do
      delete :destroy, id: @wikirace
    end

    assert_redirected_to wikiraces_path
  end
end
