class TweetsController < ApplicationController
    before_action :get_zombie
    before_action :get_tweet, only: [:show, :edit, :update, :destroy]
    #before_action :check_auth, only: [:edit, :update,  :destroy]
    def check_auth
        if session[:zombie_id] != @tweet.zombie_id
            flash[:notice] = "Sorry, you can't edit this tweet"
            redirect_to zombie_tweets_path 
        end
    end
    def index # list all tweets
        @tweets = @zombie.tweets
    end
    def edit # show an edit tweet form
        @tweet = Tweet.find(params[:id])
    end
    def show # show a single tweet
       respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @tweet }
        format.xml { render xml: @tweet }
       end
    end
    def new # show a new tweet form
        @tweet = Tweet.new
    end
    def create # create a new form
        @tweet = @zombie.tweets.new(tweets_params)
        respond_to do |format|
            if @tweet.save
              format.html { redirect_to [@zombie, @tweet], notice: 'Tweet was successfully created.' }
              format.json { render :show, status: :created, location: [@zombie, @tweet] }
            else
              format.html { render :new }
              format.json { render json: @tweet.errors, status: :unprocessable_entity }
            end
          end
    end
    def update #update a tweet
        respond_to do |format|
          if @tweet.update(tweets_params)
            format.html { redirect_to zombie_tweets_path, notice: 'Tweet was successfully updated.' }
            format.json { render :show, status: :ok, location: @tweet }
          else
            format.html { render :edit }
            format.json { render json: @tweet.errors, status: :unprocessable_entity }
          end
        end
    end
    def destroy #delete a tweet
        @tweet.destroy
        redirect_to zombie_tweets_path(), notice: "Tweet was successfully deleted."
    end
    private
        def get_zombie
            @zombie = Zombie.find(params[:zombie_id])
        end
        def get_tweet
            @tweet = Tweet.find(params[:id])
        end 
        def tweets_params# Never trust parameters from the scary internet, only allow the white list through.
            params.require(:tweet).permit(:status)
        end
end
