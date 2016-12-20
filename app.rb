require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require "sqlite3"

configure do
	@db = SQLite3::Database.new 'barbershop.db'
	@db.execute 'CREATE TABLE IF NOT EXISTS
				"Users"
					(
					"id" INTEGER PRIMARY KEY AUTOINCREMENT,
					"user_name" TEXT,
					"phone" TEXT,
					"date_stamp" TEXT,
					"barber" TEXT,
					"color" TEXT
					)'
end


get '/' do
	@error = ''
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
		@error = ''
	erb :about
end

get '/visit' do
	@error = ''
	erb :visit
end

get '/contacts' do
	@error = ''
	erb :contacts
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@master = params[:master]
	@color = params[:color]
	@error = ''

  h_err = {
      username: 'Введите имя',
      phone: 'Введите телефон',
      datetime: 'Введите дату и время'
  }

  @error = h_err.select { |key,_| params[key] == ""}.values.join(", ")
	return erb :visit if @error != ''
	

		f = File.open './public/users.txt' , 'a'
		f.write "User: #{@username}, Phone #{@phone}, Date #{@datetime}, master #{@master}, color #{@color}\n"
		f.close
	erb :visit
end

post '/contacts' do
	@email = params[:email]
	@text = params[:text]

	f = File.open './public/contacts.txt' , 'a'
	f.write "E-mail: #{@email}, Text #{@text}\n"
	f.close
	erb :contacts
end