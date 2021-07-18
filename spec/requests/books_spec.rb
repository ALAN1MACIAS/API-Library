require 'rails_helper'

describe 'Book API', type: :request do
  let(:first_author) { FactoryBot.create(:author, first_name: 'George', last_name: 'Orwell', age: 46) }
  let(:second_author) { FactoryBot.create(:author, first_name: 'H.G', last_name: 'Wells', age: 78) }

  describe 'GET /book' do
    before do
      @create1 = FactoryBot.create(:book, tile: '1984', author: first_author).id
      @create2 = FactoryBot.create(:book, tile: 'The Time Machine', author: second_author).id
    end

    it 'returns all book' do
      get '/api/v1/book'

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to eq(
        [
          {
            'id' => @create1,
            'title' => '1984',
            'author_name' => 'George Orwell',
            'author_age' => 46
          },
          {
            'id' => @create2,
            'title' => 'The Time Machine',
            'author_name' => 'H.G Wells',
            'author_age' => 78
          }
        ]
      )
    end

    it 'returns a subject of books based on limit' do
      get '/api/v1/book', params: { limit: 1 }
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            'id' => @create1,
            'title' => '1984',
            'author_name' => 'George Orwell',
            'author_age' => 46
          }
        ]
      )
    end

    it 'returns a subject of books based on limit and offset' do
      get '/api/v1/book', params: { limit: 1, offset: 1 }
      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            'id' => @create2,
            'title' => 'The Time Machine',
            'author_name' => 'H.G Wells',
            'author_age' => 78
          }
        ]
      )
    end
  end

  describe 'POST /book' do
    it 'create a new book' do
      book = { tile: 'The martian' }
      author = { first_name: 'Andy', last_name: 'Weir', age: '48' }
      expect { post '/api/v1/book', params: { book: book, author: author } }.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
      expect(response_body).to eq(
        {
          'id' => response_body['id'],
          'title' => 'The martian',
          'author_name' => 'Andy Weir',
          'author_age' => 48
        }
      )
    end
  end

  describe 'Delete /book/:id' do
    let!(:book) { FactoryBot.create(:book, tile: '1984', author: first_author) }

    it 'deletes a book' do
      expect { delete "/api/v1/book/#{book.id}" }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
