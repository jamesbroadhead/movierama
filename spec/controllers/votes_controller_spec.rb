require 'spec_helper'

RSpec.describe VotesController, type: :controller do
  before :each do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }

    allow(controller).to receive(:current_user) {
      User.create(uid: 'null|12345', name: 'Alice')
    }

    # TODO: mock the movie too?
    # TODO debug & step through :/
  end

  describe 'GET create' do
    it 'denies, without access' do
      assert_raises CanCan::AccessDenied do
        get :create, params: { movie_id: 0, t: 'like' }
      end
    end

    it 'succeeds, with access' do
      @ability.can :vote, Movie
      get :create, params: { movie_id: 0 }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET destroy' do
    it 'denies, without access' do
      assert_raises CanCan::AccessDenied do
        get :destroy, params: { movie_id: 0 }
      end
    end

    xit 'succeeds, with access' do
      @ability.can :vote, Movie
      get :create, params: { movie_id: 0 }
      expect(response).to have_http_status(:success)
    end
  end
end
