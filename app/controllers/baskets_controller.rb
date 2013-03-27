class BasketsController < ApplicationController
  # GET /baskets
  # GET /baskets.json
  def index
    @title = 'basket list'
    @baskets = Basket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @baskets }
    end
  end

  # GET /baskets/1
  # GET /baskets/1.json
  def show
    @basket = Basket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @basket }
    end
  end

  # GET /baskets/new
  # GET /baskets/new.json
  def new
    @basket = Basket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @basket }
    end
  end

  # GET /baskets/1/edit
  def edit
    @basket = Basket.find(params[:id])
  end

  # POST /baskets
  # POST /baskets.json
  def create
    @goods = []
    @debug = []
    
    params[:goods].each { | elem |
      good_id = elem[0]
      unless elem[1][:ordered].nil?
        quantity = elem[1][:quantity]
        basket = Basket.__to_basket current_user.id, good_id, quantity.to_i if quantity.to_i > 0
      end
    }

    redirect_to controller: :baskets, action: 'items' and return
  end

  # PUT /baskets/1
  # PUT /baskets/1.json
  def update
    @basket = Basket.find(params[:id])

    respond_to do |format|
      if @basket.update_attributes(params[:basket])
    redirect_to action: 'items' and return
        format.html { redirect_to @basket, notice: 'Basket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @basket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /baskets/1
  # DELETE /baskets/1.json
  def destroy
    @basket = Basket.find(params[:id])
    @basket.destroy

    respond_to do |format|
      format.html { redirect_to baskets_url }
      format.json { head :no_content }
    end
  end






  # GET /baskets/items
  # GET /profile/basket
  def items
    @title = 'User basket'
    @baskets = Basket.user_basket(current_user.id).with_names.not_sent.order 'title'
  end

  def history
    @title = 'User basket history'
    @baskets = Basket.send_or_requested current_user.id
    render 'items'
  end

  def requested # POST, redirected
    @baskets = []
    @debug = []

    Basket.__set_delivery_status_to_new current_user.id

    params[:goods].each { | elem |
      good_id = elem[0]
      basket = Basket.find good_id
      basket.__change_delivery_status_to_requested not(elem[1][:ready_to_deliver].nil?)
    } unless params[:goods].nil?

    redirect_to action: 'history' and return
  end

  def delivery # POST, redirected
    @baskets = []
    @debug = []
    
    params[:goods].each { | good |
      good_id = good[0]
      unless good[1][:ready_to_deliver].nil?
        basket = Basket.find good_id
        basket.__complete_delivery
        @baskets << basket
        @debug << "item id is #{good_id}"
      end
    } unless params[:goods].nil?

    redirect_to controller: 'users', action: 'basket'
  end

  def delivery_prepare # POST, sticky
    @baskets = []
    @debug = []

    params[:goods].each { | good |
      good_id = good[0]
      unless good[1][:ready_to_deliver].nil?
        basket = Basket.find good_id
        @baskets << basket
        @debug << "item id is #{good_id}"
      end
    } unless params[:goods].nil?
    # redirect_to controller: 'users', action: 'raise_error' # No redirection! This feature is made intentionally to allow form re-sending.
  end

end
