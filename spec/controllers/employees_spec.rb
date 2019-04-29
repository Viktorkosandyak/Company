require 'rails_helper'
RSpec.describe EmployeesController, type: :controller do
  let(:user) { User.create(email: 'test@test.com', password: "password", password_confirmation: "password") }

  before do
    sign_in user
  end

  it { should use_before_action(:authenticate_user!) }
  it { should_not use_before_action(:prevent_ssl) }

  it do
    params = {
      employee: {
        name: 'John',
        active: true,
        departament_id: 'Hr'
      }
    }
    should permit(:name, :active, :departament_id).for(:create, params: params).on(:employee)
  end

  describe "The #new action" do
    before(:each) do
      get :new
    end

    it "creates a new employee" do
      expect(assigns(:employee)).to be_a_new(Employee)
    end

    it "creates a new employee" do
        expect(response).to render_template :new
    end
  end

  describe "#show" do
    before do
      @employee = FactoryBot.create(:employee)
    end

    it "renders the #show view, responds successfully" do
      get :show, params: { id: @employee.id }
      expect(response).to be_successful
      expect(response).to render_template :show
    end
  end

  describe "#index" do
    before do
      @employee = FactoryBot.create(:employee)
    end

    it "renders the #index view,responds successfully" do
      get :index
      expect(response).to have_http_status "200"
      expect(response).to render_template :index
    end
  end

  describe "#new" do
    before do
      @employee = FactoryBot.create(:employee)
    end

    it "enders the #new view, responds successfully" do
      get :new, params: { id: @employee.id }
      expect(response).to be_successful
      expect(response).to render_template :new
    end
  end

  describe "#edit" do
    let(:employee) { FactoryBot.create(:employee) }

    it "renders the #edit view, responds successfully" do
      get :edit, params: { id: employee.id }
      expect(response).to be_successful
      expect(response).to render_template :edit
    end
  end

  describe "#update" do
    before do
      @employee = FactoryBot.create(:employee)
    end

    it "updates a employee" do
      employee_params = FactoryBot.attributes_for(:employee,
        name: "Old Employee Name", active: false)
      patch :update, params: { id: @employee.id, employee:  FactoryBot.attributes_for(:employee,
        name: "New Employee Name", active: true) }
      expect(@employee.reload.active).to eq true
      expect(@employee.reload.name).to eq "New Employee Name"
    end

    it "does not update and render edit" do
      employee_params = FactoryBot.attributes_for(:employee,
        name: "New Departament Name")
      patch :update, params: { id: @employee.id, employee:  FactoryBot.attributes_for(:employee,
        name: "") }
      expect(@employee.reload.name).to render_template :edit
    end

    it "enders the #edit view, responds successfully" do
      get :edit, params: { id: @employee.id }
      expect(response).to be_successful
      expect(response).to render_template :edit
    end
  end

  describe "#create" do
    let(:employee_params) { FactoryBot.attributes_for(:employee) }

    it 'should create new employee' do
      expect {
        post :create, params: { employee: employee_params }
      }.to change(Employee, :count).by(1)
    end
  end

  describe "#destroy" do
    let!(:employee) { FactoryBot.create(:employee) }

    it 'should create new employee' do
      expect {
        delete :destroy, params: { id: employee.id }
      }.to change(Employee, :count).by(-1)
    end

    it "redirects to #index" do
      delete :destroy, params: { id: employee.id }
      expect(response).to redirect_to employees_url
    end
  end

  it { should route(:get, root_path).to(action: :index) }
  it { should route(:get, '/employees/1').to(action: :show, id: 1) }

  it do
     should route(:get, '/', port: 3000).
     to('employees#index')
  end
end
