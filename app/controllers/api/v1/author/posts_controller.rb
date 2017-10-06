class Api::V1::Author::PostsController < Api::V1::Author::BaseController
  before_action :time_now_if_published_at_is_nil, only: :create

  def create
    post = current_user.posts.build(post_params)

    if post.save
      render json: post, status: 201
    else
      render json: { errors: post.errors.full_messages }, status: 406
    end
  end

  private

  def time_now_if_published_at_is_nil
    unless params[:published_at].present?
      params[:published_at] = Time.now
    end
  end

  def post_params
    params.permit(:title, :body, :published_at)
  end
end
