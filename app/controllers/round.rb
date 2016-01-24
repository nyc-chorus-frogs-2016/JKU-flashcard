get '/rounds/:id/' do
  round = Round.find_by(id: params[:id])
  card = round.select_random_card
  redirect "/rounds/#{params[:id]}/cards/#{card.id}/"
end

get '/rounds/:roundid/cards/:cardid/' do

  if params[:previous_answer]
    @previous_answer = params[:previous_answer]
  end

  if params[:result]
    @result = params[:result]
  end

  if
  @round = Round.find_by(id: params[:roundid])
  @card = Card.find_by(id: params[:cardid])
  erb :'cards/show'
  end

end

post '/rounds/:roundid/cards/:cardid' do
  round = Round.find_by(id: params[:roundid])
  card = Card.find_by(id: params[:cardid])

  if params[:answer] == card.answer
    Guess.create(is_correct: true, round_id: params[:roundid], card_id: params[:cardid])
    result = "correct"
  else
    Guess.create(is_correct: false, round_id: params[:roundid], card_id: params[:cardid])
    result = "incorrect"
  end
    redirect "/rounds/#{round.id}/cards/#{card.id}/?result=#{result}&previous_answer=#{params[:answer]}"
end

delete '/rounds/:id/' do
  Round.find_by(id: params[:id]).destroy
  redirect "/userprofile"
end