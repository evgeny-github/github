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
          # basket = Basket.find_by_user_id_and_good_id_and_send_completed current_user.id, good_id, FALSE

=begin
          basket = Basket.find_by_user_id_and_good_id_and_delivery_status current_user.id, good_id, 'new'
          basket = Basket.new({:user => current_user, :good => Good.find(good_id), count: 0, price: price, delivery_status: 'new' }) if basket.nil?
          basket.count += quantity.to_i
          basket.send_completed = FALSE
          basket.delivery_status = 'new'
          # basket.update_attributes basket.id
          basket.save
=end

          basket = Basket.__to_basket current_user.id, good_id, quantity.to_i
          current_user.baskets << basket
        end
      end
    }
    
    # redirect_to :action => 'items' and return
    # raise 'stop here'
    redirect_to controller: :baskets, action: 'items' and return

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
    # @baskets = Basket.find_all_by_user_id current_user.id,
    # joins: "left join goods on baskets.good_id = goods.id",
    # conditions: ["send_date is NULL"],
    # order: "title"
    
    # @baskets = Basket.with_names.user_basket(current_user.id).not_sent.order 'title'
    @baskets = Basket.user_basket(current_user.id).with_names.not_sent.order 'title'

    # @debug ||= []
    # @baskets.each { | basket |
    #   @debug << basket
    # }
    # @baskets = []
  end

  def history
    @title = 'User basket history'
    # @baskets = Basket.find_all_by_user_id current_user.id,
    # conditions: "send_date is not NULL OR delivery_status = 'requested'",
    # order: "delivery_status DESC, send_date DESC"

    @baskets = Basket.send_or_requested current_user.id
    
    # @debug ||= []
    # @baskets.each { | basket |
    #   @debug << basket
    # }
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
=begin
    # Это кусок вообще лишний. 
    # Список товаров будет формироваться другим действием, на которое перенаправляем.
    @baskets = Basket.find :all,
      select: "baskets.*, goods.title",
      # from: "baskets, goods",
      # from: "baskets",
      joins: "left join goods on baskets.good_id = goods.id",
      conditions: [
        # "(send_date is not NULL OR send_completed = 't') AND user_id = :user_id", {user_id: current_user.id}
        "(send_date is not NULL OR delivery_status = 'requested') AND user_id = :user_id", {user_id: current_user.id}
      ],
      # order: "send_completed DESC, send_date DESC, title"
      order: "delivery_status DESC, send_date DESC, title"
      
      # raise "Aborting"
      # redirect_to action: 'items' and return
=end
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
