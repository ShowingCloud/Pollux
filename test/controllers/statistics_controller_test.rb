require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  setup do
    @statistic = statistics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statistics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create statistic" do
    assert_difference('Statistic.count') do
      post :create, statistic: { round_accounts: @statistic.round_accounts, round_ant: @statistic.round_ant, round_avg_btc: @statistic.round_avg_btc, round_btc: @statistic.round_btc, round_rate: @statistic.round_rate, round_trans: @statistic.round_trans, stat_time: @statistic.stat_time, total_accounts: @statistic.total_accounts, total_ant: @statistic.total_ant, total_avg_btc: @statistic.total_avg_btc, total_btc: @statistic.total_btc, total_rate: @statistic.total_rate, total_trans: @statistic.total_trans }
    end

    assert_redirected_to statistic_path(assigns(:statistic))
  end

  test "should show statistic" do
    get :show, id: @statistic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @statistic
    assert_response :success
  end

  test "should update statistic" do
    patch :update, id: @statistic, statistic: { round_accounts: @statistic.round_accounts, round_ant: @statistic.round_ant, round_avg_btc: @statistic.round_avg_btc, round_btc: @statistic.round_btc, round_rate: @statistic.round_rate, round_trans: @statistic.round_trans, stat_time: @statistic.stat_time, total_accounts: @statistic.total_accounts, total_ant: @statistic.total_ant, total_avg_btc: @statistic.total_avg_btc, total_btc: @statistic.total_btc, total_rate: @statistic.total_rate, total_trans: @statistic.total_trans }
    assert_redirected_to statistic_path(assigns(:statistic))
  end

  test "should destroy statistic" do
    assert_difference('Statistic.count', -1) do
      delete :destroy, id: @statistic
    end

    assert_redirected_to statistics_path
  end
end
