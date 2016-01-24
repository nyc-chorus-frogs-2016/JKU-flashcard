get '/users/new' do
  erb :'users/new', layout: false
end

post '/users' do

  @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password_hash: nil)
  @user.password = params[:password]

  if @user.save && (params[:password] != "")
    session[:user_id] = @user.id
    redirect '/'
  else
    @errors = @user.errors.full_messages
    if params[:password] == ""
      @errors << "Password can't be blank"
    end
    erb :'users/new'
  end
end

get "/userprofile" do
  erb :'users/show'
end
