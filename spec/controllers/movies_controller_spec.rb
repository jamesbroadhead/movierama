require 'spec_helper'

RSpec.describe MoviesController, type: :controller do
  before :each do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
  end

  describe 'GET index' do
    it 'succeed, logged out' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET new' do
    it 'denies, without access' do
      assert_raises CanCan::AccessDenied do
        get :new
      end
    end

    # TODO: is this the correct template to render?
    it 'succeeds, with access' do
      @ability.can :create, Movie
      get :index
      assert_template :index
    end
  end

  describe 'POST create' do
    it 'denies, without access' do
      assert_raises CanCan::AccessDenied do
        post :create
      end
    end

    it 'succeeds, with access' do
      @ability.can :create, Movie
      post :create
      assert_template('movies/new')
    end
  end
end
