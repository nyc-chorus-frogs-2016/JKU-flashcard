def logged_in?
  !!session[:user_id] && current_user
end

def current_user
  User.find_by(id: session[:user_id])
end

def authroized_player(id)
  Round.find_by(id: id).user.id == current_user.id
end
