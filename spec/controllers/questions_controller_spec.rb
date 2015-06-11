require 'rails_helper'

	describe QuestionsController do
	  let(:question) { create(:question) }

	  describe "GET #index" do
	    let(:questions) { create_list(:question, 2) }
	    
	    before { get :index } 
	
	    it "populates an array of all questions" do       
	      expect(assigns(:questions)).to match_array(questions)
	    end
	    it "render index view" do
	      expect(response).to render_template :index
	    end
	  end

	  describe 'GET #show' do
	    let(:question) { create(:question) }
	    
	    before { get :show, id: question }

	    it 'assigns the requested question to question' do
	      expect(assigns(:question)).to eq question
	    end
	    it 'renders show view' do
	      expect(response).to render_template :show
	    end
	  end
  
	  describe 'GET #new' do
		before { get :new }

		it 'get a new question object' do
		  expect(assigns(:question)).to be_a_new(Question)
		end

		it { should render_template :new }
	  end

	  describe 'GET #edit' do
	  	let(:question) { create(:question) }
	  	
	  	before { get :edit, id: question }

	  	it 'assings the requested question to @question'do
	  	  expect(assigns(:question)).to eq question
	    end
	    it 'renders edit view' do
	      expect(response).to render_template :edit
	    end
	  end

	end
  