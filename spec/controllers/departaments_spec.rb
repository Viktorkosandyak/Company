require 'rails_helper'
RSpec.describe DepartamentsController, type: :controller do
  let(:user) { User.create(email: 'test@test.com', password: "password", password_confirmation: "password") }

  before do
    sign_in user
  end

  it { should use_before_action(:authenticate_user!) }
  it { should_not use_before_action(:prevent_ssl) }

  it do
    params = {
      departament: {
        name: 'John'
      }
    }
    should permit(:name).for(:create, params: params).on(:departament)
  end

  describe "The #new action" do
    before(:each) do
      get :new
    end

    it "creates a new departament" do
      expect(assigns(:departament)).to be_a_new(Departament)
    end

    it "creates a new departament" do
        expect(response).to render_template :new
    end
  end

  describe "#show" do
    before do
      @departament = FactoryBot.create(:departament)
    end

    it "renders the #show view, responds successfully" do
      get :show, params: { id: @departament.id }
      expect(response).to be_successful
      expect(response).to render_template :show
    end
  end

  describe "#index" do
    before do
      @departament = FactoryBot.create(:departament)
    end

    it "renders the #index view,responds successfully" do
      get :index
      expect(response).to have_http_status "200"
      expect(response).to render_template :index
    end
  end

  describe "#new" do
    before do
      @departament = FactoryBot.create(:departament)
    end

    it "enders the #new view, responds successfully" do
      get :new, params: { id: @departament.id }
      expect(response).to be_successful
      expect(response).to render_template :new
    end
  end

  describe "#edit" do
    let(:department) { FactoryBot.create(:departament) }

    it "renders the #edit view, responds successfully" do
      get :edit, params: { id: department.id }
      expect(response).to be_successful
      expect(response).to render_template :edit
    end
  end

  describe "#update" do
    before do
      @departament = FactoryBot.create(:departament)
    end

    it "updates a departament" do
      departament_params = FactoryBot.attributes_for(:departament,
        name: "Old Departament Name")
      patch :update, params: { id: @departament.id, departament:  FactoryBot.attributes_for(:departament,
        name: "New Departament Name") }
      expect(@departament.reload.name).to eq "New Departament Name"
    end

    it "does not update and render edit" do
      departament_params = FactoryBot.attributes_for(:departament,
        name: "New Departament Name")
      patch :update, params: { id: @departament.id, departament:  FactoryBot.attributes_for(:departament,
        name: "") }
      expect(@departament.reload.name).to render_template :edit
    end

    it "enders the #edit view, responds successfully" do
      get :edit, params: { id: @departament.id }
      expect(response).to be_successful
      expect(response).to render_template :edit
    end
  end

  describe "#create" do
    let(:departament_params) { FactoryBot.attributes_for(:departament) }

    it 'should create new department' do
      expect {
        post :create, params: { departament: departament_params }
      }.to change(Departament, :count).by(1)
    end
  end

  describe "#destroy" do
    let!(:departament) { FactoryBot.create(:departament) }

    it 'should create new department' do
      expect {
        delete :destroy, params: { id: departament.id }
      }.to change(Departament, :count).by(-1)
    end

    it "redirects to #index" do
      delete :destroy, params: { id: departament.id }
      expect(response).to redirect_to departaments_url
    end
  end

    it { should route(:get, '/departaments').to(action: :index) }
    it { should route(:get, '/departaments/1').to(action: :show, id: 1) }

    it do
       should route(:get, '/departaments', port: 3000).
       to('departaments#index')
    end
end
