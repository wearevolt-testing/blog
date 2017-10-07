module PostsHelper
  def hash_to_top(collection)
    posts = ActiveModel::Serializer::CollectionSerializer.new(
      collection,
      serializer: Api::V1::PostSerializer
    )
    total_pages = collection.total_pages
    posts_count = collection.size

    result = []

    result << { total_pages: total_pages, posts_count: posts_count }

    posts.each do |element|
      result << element
    end

    result
  end
end
