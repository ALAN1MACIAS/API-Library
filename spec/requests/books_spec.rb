require 'rails_helper'

describe 'Book API', type: :request do
  describe 'GET /book' do
    before do
      FactoryBot.create(:book, tile: '1984', author: 'George Orwell')
      FactoryBot.create(:book, tile: 'The Time Machine', author: 'H.G Wells')
    end

    it 'returns all book' do
      get '/api/v1/book'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'POST /book' do
    it 'create a new book' do
      expect { post '/api/v1/book', params: { tile: 'The martian', author: 'Andy Weir' } }.to change { Book.count }.from(1).to(2)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'Delete /book/:id' do
    let!(:book) { FactoryBot.create(:book, tile: '1984', author: 'George Orwell') }

    it 'deletes a book' do
      expect { delete "/api/v1/book/#{book.id}" }.to change { Book.count }.from(2).to(1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
