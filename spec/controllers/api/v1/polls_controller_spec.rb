require 'spec_helper'

describe Api::V1::PollsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let!(:poll){ FactoryGirl.create(:poll, user: user)}

  describe '#index' do
    it 'redirects to login page if user is not logged in' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    context 'user logged in' do
      before do
        login_user user, controller, PollSerializer
      end
      it 'returns list of polls' do
        result = oauth_get page, api_v1_polls_path
        polls = Poll.all
        expect(polls.count).to_not eq 0
        expect(result.to_json).to eq polls.map{ |p| PollSerializer.new(p).as_json }.to_json
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#search' do
    it 'redirects to login page if user is not logged in' do
      get :search
      expect(response).to redirect_to(new_user_session_path)
    end

    context 'user logged in' do
      let!(:poll_1){ FactoryGirl.create(:poll, user: user, title: 'aaaaaaa')}
      let!(:poll_2){ FactoryGirl.create(:poll, user: user, title: 'bbbbbbb')}
      before do
        login_user user, controller, PollSerializer
      end
      it 'returns filtered list of polls' do
        result = oauth_get(page, search_api_v1_polls_path(search: 'aa'))
        polls = Poll.search('aa')
        expect(result.to_json).to eq polls.map{ |p| PollSerializer.new(p).as_json }.to_json
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#show' do
    it 'redirects to login page if user is not logged in' do
      get :show, {id: poll.id}
      expect(response).to redirect_to(new_user_session_path)
    end

    context 'user logged in' do
      before do
        login_user user, controller, PollSerializer
      end
      it 'returns a poll' do
        result = oauth_get(page, api_v1_poll_path(poll.id))
        poll.reload
        expect(result['id']).to eq poll.id
        expect(result.keys.sort).to eq  PollSerializer.new(poll).as_json.stringify_keys.keys.sort
      end
    end
  end

  describe '#create' do
    it 'redirects to login page if user is not logged in' do
      post :create, {title: "simple title"}
      expect(response).to redirect_to(new_user_session_path)
    end

    context 'user logged in' do
      before do
        login_user user, controller, PollSerializer
      end
      it 'creates the poll' do
        response = oauth_post page, api_v1_polls_path(user), {title: "simple title", description: "simple description", poll_type: 'checkbox'}
        page.driver.response.status.should eq 200
        Poll.find(response['id']).title.should eq "simple title"
      end
    end
  end

  describe '#update' do
    it 'redirects to login page if user is not logged in' do
      put :update, {id: poll.id}
      expect(response).to redirect_to(new_user_session_path)
    end

    context 'user logged in' do
      before do
        login_user user, controller, PollSerializer
      end
      it 'updates the poll and sets answers as answered' do
        @poll = oauth_get(page, api_v1_poll_path(poll.id))
        expect(@poll['user_voted']).to eq false
        expect(@poll['voting_results']).to eq nil

        result = oauth_put(page, api_v1_poll_path(poll.id), {answer_ids: [poll.answers.first.id]})

        expect(result['user_voted']).to eq true
        expect(result['voting_results'].length).to eq(1)
        expect(result['voting_results'][0]).to eq([1,1])
      end
    end
  end

  describe '#destroy' do
    it 'redirects to login page if user is not logged in' do
      delete :destroy, {id: poll.id}
      expect(response).to redirect_to(new_user_session_path)
    end

    context 'user logged in' do
      before do
        login_user user, controller, PollSerializer
      end
      it 'destroys the poll' do
        oauth_del(page, api_v1_poll_path(poll.id))
        expect(Poll.where(id: poll.id).first).to eq(nil)
      end
    end
  end
end
