require 'sinatra'
require 'sinatra/reloader'

get '/' do 
	"The secret number is #{rand(101)}"
end