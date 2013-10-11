set :session_expire, 60*60
set :session_fail, '/session-failed'
set :session_secret, 's3cr3tpass'

get '/' do

	if session?
		redirect '/main'
	else
		erb :index
	end
end

get '/post/:post_id' do

	@post = Post.find(params[:post_id])

	erb :_post_content
end

get '/session-failed' do

	erb :failed_session
end


#from index and non-authors

get '/main' do 
	@posts = Post.all

	erb :main
end



#=========== POST ============


#from index.erb form

post '/login' do 

	email = params[:email]
	password = params[:password]
	
	#if authentication fails, @user is nil
	@user = User.authenticate(email, password)

	@errors = nil

	if @user
		session[:user_id] = @user.id
		session_start! 
		erb :profile
	else
		@errors = "Login Failed, the username and/or password you provided was not valid."
		redirect to '/session-failed'
	end
end

#from profile.erb

post '/create-post' do

	@user = User.find(session[:user_id])
	tag_name = params[:name]

	title = params[:title]
	content = params[:content]


	@tag = Tag.find_by_name(tag_name)

	if @tag.nil?

		@tag = Tag.create(name: tag_name)
		
		@post = Post.create(title: title, content: content, tag_id: @tag.id, user_id: @user.id)
	else
		@post = Post.create(title: title, content: content, tag_id: @tag.id, user_id: @user.id)
	end

	redirect to '/main'
end




