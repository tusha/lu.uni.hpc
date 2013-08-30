require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { crypted_password: @user.crypted_password, email: @user.email, firstname: @user.firstname, id_account: @user.id_account, id_address: @user.id_address, isactive: @user.isactive, kind: @user.kind, lastlogindate: @user.lastlogindate, lastname: @user.lastname, loginretries: @user.loginretries, mobile: @user.mobile, password_salt: @user.password_salt, persistence_token: @user.persistence_token, phonenumber: @user.phonenumber, role: @user.role, secretanswer: @user.secretanswer, secretquestion: @user.secretquestion, username: @user.username }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { crypted_password: @user.crypted_password, email: @user.email, firstname: @user.firstname, id_account: @user.id_account, id_address: @user.id_address, isactive: @user.isactive, kind: @user.kind, lastlogindate: @user.lastlogindate, lastname: @user.lastname, loginretries: @user.loginretries, mobile: @user.mobile, password_salt: @user.password_salt, persistence_token: @user.persistence_token, phonenumber: @user.phonenumber, role: @user.role, secretanswer: @user.secretanswer, secretquestion: @user.secretquestion, username: @user.username }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
