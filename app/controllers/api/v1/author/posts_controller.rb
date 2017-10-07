class Api::V1::Author::PostsController < Api::V1::Author::BaseController
  include PostsHelper

  before_action :time_now_if_published_at_is_nil, only: :create

  def index
    posts = current_user.posts.includes(:author).recent.page(params[:page]).per(params[:per_page])

    if params[:page].present? && params[:per_page].present?
      render json: hash_to_top(posts), status: 200
    else
      render_error 'Incorrect parameters', 406
    end
  end

  def show
    post = current_user.posts.find_by(id: params[:post_id])

    if post.present?
      render json: post, status: 200
    else
      render_error 'Post not found', 406
    end
  end

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
