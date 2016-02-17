class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      redirect "/account"
    else
      erb :"users/signup"
    end
  end

  post "/signup" do
    if User.all.find { |user| user.username == params[:username] }
      return erb :"users/signup", locals: {message: "The username is already taken."}
    else
      @user = User.new(username: params[:username], password: params[:password])

    end
    if @user.save
      @account = Account.create(balance: 0, user_id: @user.id)      
      session[:id] = @user.id
      redirect "/account"
    else
      redirect "/signup"
    end
  end

  get "/login" do
    if logged_in?
      redirect "/account"
    else
      erb :"users/login"
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/account"
    else
      erb :"users/login", locals: {message: "Incorrect login information."}
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/"
    else
      redirect "/login"
    end
  end
end