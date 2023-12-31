class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id then
            @is_room = true
            @room_id = current.room_id
          end
        end
      end
      if @is_room
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    @book = Book.new
    @books = @user.books
  end
    # @user = User.find(params[:id])
    # @books = @user.books
    # @book_new = Book.new
    # @following_users = @user.following_users
    # @follower_users = @user.follower_users

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end


  def followers
    user = User.find(params[:id])
    @users = user.follower_users
  end

  
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
