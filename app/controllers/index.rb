get '/' do
  if params[:error]
    @error = "Wrong E-mail/Password!"
  end

  @decks = Deck.all
  erb :'index'
end
