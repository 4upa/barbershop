require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@master = params[:master]
	@color = params[:color]
	@error = ""
	need_coma = false

	if (@username == "") or (@phone == "") or (@datetime == "") or (@master == "")
		@error = "Введите "
		if @username == ""
			@error = @error + 'имя'
			need_coma = true
		end
		if @phone == ""
			if need_coma 
				@error = @error + ', '
			end
			@error = @error + 'номер телефона'
			need_coma = true
		end
		if @datetime == ""
			if need_coma 
				@error = @error + ', '
			end
			@error = @error + 'время посещения'
		end
		@error = @error + '.'

	
	else
		f = File.open './public/users.txt' , 'a'
		f.write "User: #{@username}, Phone #{@phone}, Date #{@datetime}, master #{@master}, color #{@color}\n"
		f.close
	end
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