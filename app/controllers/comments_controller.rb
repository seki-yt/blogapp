class CommentsController < ApplicationController
  def new
    #params[:article_id]で/articles/:article_id/commentsのarticle_idが取れる
    #必ず新しく投稿する場合は空のbuildを作る
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    if @comment.save
      redirect_to article_path(article), notice: 'コメントを追加'
    else
      flash.now[:error] = '更新できませんでした'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end