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
    @debug = [123]
    
    params[:goods].each { | elem |
      good_id = elem[0]
      
      #~ @debug << elem[1][:quantity]
      unless elem[1][:ordered].nil?
        quantity = elem[1][:quantity]
        if quantity.to_i > 0
          good = Good.find good_id
          price = good.price # ordered good price can be different from current price
          @debug << "item id is #{good_id}"
          @debug << elem[1][:ordered]
          @debug << elem[1][:quantity]
          @debug << current_user.class
          #~ basket = current_user.baskets.new
          #basket = current_user.baskets.create({:good => Good.find(good_id)})
          basket = Basket.find_by_user_id_and_good_id_and_send_completed current_user.id, good_id, FALSE
          basket = Basket.new({:user => current_user, :good => Good.find(good_id), count: 0, price: price  }) if basket.nil?
          basket.count += quantity.to_i
          basket.send_completed = FALSE
          current_user.baskets << basket
        end
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



  # GET /baskets/items
  def items
    @title = 'User basket'
    # @baskets = Basket.all
    @baskets = Basket.find_all_by_user_id current_user.id
    
    
    @debug ||= []
    #~ @debug << @baskets.class.inspect
    @baskets.each { | basket |
      # basket.good_id = 'title'
      #~ basket.good_id = 123
      @debug << basket
    }

  end

end
