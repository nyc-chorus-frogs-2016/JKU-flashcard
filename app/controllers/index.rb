get '/' do
  if params[:error]
    @error = "wrong credentials"
  end

  @decks = Deck.all
  erb :'index'
end
