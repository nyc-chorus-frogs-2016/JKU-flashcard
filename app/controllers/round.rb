#ZM: It seems weird to me that the get for a round
# immeditatly redirects you. What happens if there are no
# cards left?
get '/rounds/:id/' do
  round = Round.find_by(id: params[:id])
  card = round.select_random_card
  redirect "/rounds/#{params[:id]}/cards/#{card.id}/"
end

#ZM: Naming conventions :round_id, :card_id
get '/rounds/:roundid/cards/:cardid/' do

  #ZM: Based off the redirect from the route above, this
  # will never be a value. If there is another way to get to
  # this route, maybe it should just be a new route. 
  if params[:previous_answer]
    @previous_answer = params[:previous_answer]
  end

  #ZM: Same comment as above
  if params[:result]
    @result = params[:result]
  end

  #ZM: What is this empty if statement? 
  if
    @round = Round.find_by(id: params[:roundid])
    @card = Card.find_by(id: params[:cardid])
    erb :'cards/show'
  end

end

post '/rounds/:roundid/cards/:cardid' do
  round = Round.find_by(id: params[:roundid])
  card = Card.find_by(id: params[:cardid])

  #ZM: This should be a method on the card...
  #ZM: if card.is_correct?(params[:answer])
  #ZM: If we do that, we don't need the else
  if params[:answer] == card.answer

    #ZM: Guess.create(is_correct: card.is_correct?(params[:answer], 
    #                 round_id: params[:round_id], 
    #                 card_id: params[:card_id]))

    Guess.create(is_correct: true, round_id: params[:roundid], card_id: params[:cardid])
    result = "correct"
  else
    Guess.create(is_correct: false, round_id: params[:roundid], card_id: params[:cardid])
    result = "incorrect"
  end
    #redirect "/rounds/round.id/cards/card.id/?result=card.is_correct&prev=params[:answer]" 
    redirect "/rounds/#{round.id}/cards/#{card.id}/?result=#{result}&previous_answer=#{params[:answer]}"
  #ZM: Missing End  
end

delete '/rounds/:id/' do
  Round.find_by(id: params[:id]).destroy
  redirect "/userprofile"
end