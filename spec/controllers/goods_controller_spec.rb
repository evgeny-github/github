require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe GoodsController do

  # This should return the minimal set of attributes required to create a valid
  # Good. As you add validations to Good, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all goods as @goods" do
      good = Good.create! valid_attributes
      get :index
      assigns(:goods).should eq([good])
    end
  end

  describe "GET show" do
    it "assigns the requested good as @good" do
      good = Good.create! valid_attributes
      get :show, :id => good.id.to_s
      assigns(:good).should eq(good)
    end
  end

  describe "GET new" do
    it "assigns a new good as @good" do
      get :new
      assigns(:good).should be_a_new(Good)
    end
  end

  describe "GET edit" do
    it "assigns the requested good as @good" do
      good = Good.create! valid_attributes
      get :edit, :id => good.id.to_s
      assigns(:good).should eq(good)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Good" do
        expect {
          post :create, :good => valid_attributes
        }.to change(Good, :count).by(1)
      end

      it "assigns a newly created good as @good" do
        post :create, :good => valid_attributes
        assigns(:good).should be_a(Good)
        assigns(:good).should be_persisted
      end

      it "redirects to the created good" do
        post :create, :good => valid_attributes
        response.should redirect_to(Good.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved good as @good" do
        # Trigger the behavior that occurs when invalid params are submitted
        Good.any_instance.stub(:save).and_return(false)
        post :create, :good => {}
        assigns(:good).should be_a_new(Good)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Good.any_instance.stub(:save).and_return(false)
        post :create, :good => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested good" do
        good = Good.create! valid_attributes
        # Assuming there are no other goods in the database, this
        # specifies that the Good created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Good.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => good.id, :good => {'these' => 'params'}
      end

      it "assigns the requested good as @good" do
        good = Good.create! valid_attributes
        put :update, :id => good.id, :good => valid_attributes
        assigns(:good).should eq(good)
      end

      it "redirects to the good" do
        good = Good.create! valid_attributes
        put :update, :id => good.id, :good => valid_attributes
        response.should redirect_to(good)
      end
    end

    describe "with invalid params" do
      it "assigns the good as @good" do
        good = Good.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Good.any_instance.stub(:save).and_return(false)
        put :update, :id => good.id.to_s, :good => {}
        assigns(:good).should eq(good)
      end

      it "re-renders the 'edit' template" do
        good = Good.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Good.any_instance.stub(:save).and_return(false)
        put :update, :id => good.id.to_s, :good => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested good" do
      good = Good.create! valid_attributes
      expect {
        delete :destroy, :id => good.id.to_s
      }.to change(Good, :count).by(-1)
    end

    it "redirects to the goods list" do
      good = Good.create! valid_attributes
      delete :destroy, :id => good.id.to_s
      response.should redirect_to(goods_url)
    end
  end

end
