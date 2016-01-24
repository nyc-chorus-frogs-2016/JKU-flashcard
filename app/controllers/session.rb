post '/sessions' do
  user = User.find_by(email: params[:email])
  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/?error=wrong'
  end

end

delete '/sessions/logout' do
  session.clear()
  redirect '/'
end
