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
    
    redirect_to :action => 'items' and return

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
    # @baskets = Basket.all
    @baskets = Basket.find_all_by_user_id current_user.id,
    joins: "left join goods on baskets.good_id = goods.id",
    conditions: ["send_date is NULL"],
    order: "title"
    
    @debug ||= []
    #~ @debug << @baskets.class.inspect
    @baskets.each { | basket |
      # basket.good_id = 'title'
      #~ basket.good_id = 123
      @debug << basket
    }
  end

  def history
    @title = 'User basket history'
    # @baskets = Basket.all
    @baskets = Basket.find_all_by_user_id_and_delivery_requested current_user.id, TRUE,
    # @baskets = Basket.find_all_by_user_id_and_send_completed current_user.id, TRUE,
    order: "send_completed DESC, send_date DESC"
    
    @debug ||= []
    #~ @debug << @baskets.class.inspect
    @baskets.each { | basket |
      # basket.good_id = 'title'
      #~ basket.good_id = 123
      @debug << basket
    }
    render 'items'

  end

  def requested

    @baskets = []
    @debug = []
    
    Basket.update_all("send_completed = 'f'", "user_id = #{current_user.id} and send_date is not NULL")
    # baskets_all = Basket.find_all_by_user_id current_user.id
    # baskets_all.each { | basket |
    #   next unless basket.send_date.nil?
    #   good_id = basket.id
    #   # @debug << params["goods"].to_hash[good_id.to_s].class
    #   unless params["goods"].to_hash[good_id.to_s].nil?
    #   @debug << params["goods"].to_hash[good_id.to_s][:ready_to_deliver]
    #   end
        
    #   # [:ready_to_deliver]
    #   # @debug << params["goods"].class
    #   # @debug << params["goods[#{good_id}][ready_to_deliver]"]
    #   # @debug << "item id is #{good_id}"
    #   # item = params["goods[#{good_id}]"]
    #   # @debug << item
    #   # @debug << params[:goods]
    #   # @debug << params[:authenticity_token].class
    #   # @debug << params[:utf8]
    #   # puts @debug << params[:goods]


    #       # Нет выборки параметра POST
    #       basket.send_completed = FALSE
    #       # basket.save

    #   # if params[:goods][good_id].nil? or params[:goods][good_id][:ready_to_deliver].nil?
    #   #     basket.send_completed = FALSE
    #   #     basket.save
    #   # else
    #   #   basket.send_completed = TRUE
    #   #   # Date is changed when user's request is completed by 'warehouse worker'
    #   #   # basket.send_date = Time.now
    #   #   basket.save
    #   #   @debug << "item id is #{good_id}"
    #   # end
    # }

    params[:goods].each { | elem |
      good_id = elem[0]
      
        basket = Basket.find good_id
      if elem[1][:ready_to_deliver].nil?
        if basket.send_date.nil?
          basket.send_completed = FALSE
          basket.save
        end
      else
        basket = Basket.find good_id
        basket.send_completed = TRUE
        # Date is changed when user's request is completed by 'warehouse worker'
        # basket.send_date = Time.now
        basket.save
        @debug << "item id is #{good_id}"
        
      end
    } unless params[:goods].nil?

    @baskets = Basket.find :all,
      select: "baskets.*, goods.title",
      # from: "baskets, goods",
      # from: "baskets",
      joins: "left join goods on baskets.good_id = goods.id",
      conditions: [
        "(send_date is not NULL OR send_completed = 't') AND user_id = :user_id", {user_id: current_user.id}
      ],
      order: "send_completed DESC, send_date DESC, title"
      
      # raise "Aborting"
      # redirect_to action: 'items' and return
      redirect_to action: 'history' and return
  end

  def delivery

    @baskets = []
    @debug = []
    
    params[:goods].each { | good |
      good_id = good[0]
      
      unless good[1][:ready_to_deliver].nil?
        basket = Basket.find good_id
        # basket.send_completed = TRUE
        # Date is changed when user's request is completed by 'warehouse worker'
        basket.send_date = Time.now
        basket.save
        @baskets << basket
        @debug << "item id is #{good_id}"
        
      end
    } unless params[:goods].nil?
      
  end

end
