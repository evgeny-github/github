class UsersController < ApplicationController

  before_filter :cancel_on_restriction, :only => [:update]
  before_filter :authenticate_user!
  
  def cancel_on_restriction
    if params['dont'] == '1'
      # flash[:notice] = 'User modification denied.'
      # redirect_to users_path and return
      flash.now[:error] = 'User modification denied.'
      #~ redirect_to :action => 'edit', :status => 403 and return false
      redirect_to :action => 'edit' and return false
    end
  end


  
  # GET /users
  # GET /users.json
  def index
    @title = 'user index'
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # @user = User.find(params[:id])
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end







  # GET /users/:id/basket
  def basket
    
    @debug = []
    @baskets = Basket.find_all_by_user_id_and_send_date current_user.id, nil,
      select: "baskets.*, goods.title",
      # from: "baskets, goods",
      joins: "left join goods on baskets.good_id = goods.id",
      # order: "send_completed DESC, title"
      order: "delivery_status DESC, title"
    @debug << @baskets
  end
end
