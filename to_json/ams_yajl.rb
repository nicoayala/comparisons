require 'active_model_serializers'
require 'yajl/json_gem'

class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name
  has_many :books
end

class GenreSerializer < ActiveModel::Serializer
  attributes :id, :title, :description
  has_many :books
end

class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :published_at
  has_many :authors
  belongs_to :genre
end

def run!
  ActiveModelSerializers::SerializableResource
    .new(DATA.sample).serializable_hash.to_json
end

def run_many!
  ActiveModelSerializers::SerializableResource
    .new(DATA).serializable_hash.to_json
end

def run_include_all!
  ActiveModelSerializers::SerializableResource.new(
    DATA,
    include: ['authors', 'genre']
  ).serializable_hash.to_json
end

def run_include_deep!
  ActiveModelSerializers::SerializableResource.new(
    DATA.sample,
    include: [
      'authors',
      'authors.books',
      'authors.books.genre',
      'authors.books.genre.books',
      'authors.books.genre.books.authors',
      'authors.books.genre.books.genre'
    ]
  ).serializable_hash.to_json
end
