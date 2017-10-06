class Api::V1::PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :published_at, :author_nickname

  def author_nickname
    object.author.nickname
  end
end
