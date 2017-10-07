class Api::V1::Author::CommentsController < Api::V1::Author::BaseController
  def create
    comment = current_user.comments.build(comment_params)
    comment.commentable = parent

    return render_error 'Post not found', 406 if parent.blank?

    if comment.save
      render_success 'Comment was succesfully created', 201
    else
      render json: { errors: comment.errors.full_messages }, status: 406
    end
  end

  def destroy
    comment = current_user.comments.find_by(id: params[:comment_id])

    return render_error 'Comment not found' unless comment.present?

    comment.destroy

    render_success 'Comment was succesfully destroyed', 200
  end

  private

  def parent
    @parent ||=
      if params[:post_id].present?
        Post.find_by(id: params[:post_id])
      end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
