class GoodsController < ApplicationController

  def order3
    # @goods = Good.find([1,2,5])
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
      end
    }
    #~ @goods = Good.find([])
    #~ @debug << @goods.size
    #~ @goods = Good.find([items])
    #~ @debug << @goods[0].attributes['count']
    #~ @debug = items

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goods }
    end
  end


  def order2
    @goods = Good.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goods }
    end
  end

  def order
    @goods = Good.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goods }
    end
  end

  # GET /goods
  # GET /goods.json
  def index
    @title = 'goods list'
    @goods = Good.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goods }
    end
  end

  # GET /goods/1
  # GET /goods/1.json
  def show
    @good = Good.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @good }
    end
  end

  # GET /goods/new
  # GET /goods/new.json
  def new
    @good = Good.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @good }
    end
  end

  # GET /goods/1/edit
  def edit
    @good = Good.find(params[:id])
  end

  # POST /goods
  # POST /goods.json
  def create
    @good = Good.new(params[:good])

    respond_to do |format|
      if @good.save
        format.html { redirect_to @good, notice: 'Good was successfully created.' }
        format.json { render json: @good, status: :created, location: @good }
      else
        format.html { render action: "new" }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /goods/1
  # PUT /goods/1.json
  def update
    @good = Good.find(params[:id])

    respond_to do |format|
      if @good.update_attributes(params[:good])
        format.html { redirect_to @good, notice: 'Good was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goods/1
  # DELETE /goods/1.json
  def destroy
    @good = Good.find(params[:id])
    @good.destroy

    respond_to do |format|
      format.html { redirect_to goods_url }
      format.json { head :no_content }
    end
  end
end
