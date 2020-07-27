require_relative 'gossip'


class ApplicationController < Sinatra::Base



  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossip/:name' do
    erb :index_gossip, locals: {gossip: Gossip.find(params[:name].to_i)}
  end

  get '/gossips/:id/edit' do
   erb :edit, locals: { gossip: Gossip.find(params[:id].to_i), id: params['id'] }
  end

  post '/gossips/edit/:id' do
  Gossip.edit(params['id'].to_i, params['up_author'], params['up_content'])
   redirect '/'
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    puts 'params ajoutés au fichier .csv'
    redirect '/'
  end
end
