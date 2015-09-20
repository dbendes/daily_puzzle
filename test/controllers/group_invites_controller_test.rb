require 'test_helper'

class GroupInvitesControllerTest < ActionController::TestCase
  setup do
    @group_invite = group_invites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_invites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_invite" do
    assert_difference('GroupInvite.count') do
      post :create, group_invite: { email: @group_invite.email, group_id: @group_invite.group_id }
    end

    assert_redirected_to group_invite_path(assigns(:group_invite))
  end

  test "should show group_invite" do
    get :show, id: @group_invite
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_invite
    assert_response :success
  end

  test "should update group_invite" do
    patch :update, id: @group_invite, group_invite: { email: @group_invite.email, group_id: @group_invite.group_id }
    assert_redirected_to group_invite_path(assigns(:group_invite))
  end

  test "should destroy group_invite" do
    assert_difference('GroupInvite.count', -1) do
      delete :destroy, id: @group_invite
    end

    assert_redirected_to group_invites_path
  end
end
