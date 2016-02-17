class AccountsController < ApplicationController

  get "/account" do
    if logged_in?
      @user = current_user
      erb :"accounts/account"
    else
      redirect "/login"
    end
  end

  patch "/account" do
    @user = current_user
    @account = current_account
    funds = @account.balance
    if !Account.input_valid?(params)
      erb :"users/account", locals: {message: "There was an error processing the transaction. Please try again."}
    elsif !Account.update_balance(funds, params)
      erb :"users/failure", locals: {message: "There was an error processing the transaction. Please try again."}
    else
      @account.balance = Account.update_balance(funds, params)
      @account.save
      erb :"accounts/account"
    end
  end
end