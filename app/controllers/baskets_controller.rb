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
    items = []
    @debug = [:a, :abs]
    @debug = []
    params.each_with_index { | v, i |
      #~ @debug << i
      #~ @debug << v[1] #if @debug == []
      if v[0] =~ %r^item_(\d+)_order$
        # if params['item_NN_order'] == '1' 
        # then find item
        id = $1
        quantity = params["item_#$1_cnt"]
        @debug << "item #$1"
        @debug << params["item_#$1_cnt"]
        items << $1
        item = Good.find id
        @debug << item.attributes['count']
        #~ item.attributes['count'] = params["item_#{id}_cnt"]
        item.count = params["item_#{id}_cnt"]
        @debug << item.attributes['count']
        @goods << item
        # items << item.id
        
        #~ basket_item = Basket.new do | elem |
          #~ elem.user_id = 2 # Hard-code
          #~ elem.good_id = id
          #~ elem.count = quantity
          #~ elem.price = item.price
          #~ elem.send = FALSE
          #~ elem.send_date = nil
        #~ end
        #~ basket_item.save
        basket_item = Basket.new
        #~ basket_item = Basket.create(:user_id => 2, :good_id => id, :count => quantity)
        
      end
    }
    
    redirect_to :action => 'index' and return

    #~ @basket = Basket.new(params[:basket])

    #~ respond_to do |format|
      #~ if @basket.save
        #~ format.html { redirect_to @basket, notice: 'Basket was successfully created.' }
        #~ format.json { render json: @basket, status: :created, location: @basket }
      #~ else
        #~ format.html { render action: "new" }
        #~ format.json { render json: @basket.errors, status: :unprocessable_entity }
      #~ end
    #~ end
  end

  # PUT /baskets/1
  # PUT /baskets/1.json
  def update
    @basket = Basket.find(params[:id])

    respond_to do |format|
      if @basket.update_attributes(params[:basket])
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
end
