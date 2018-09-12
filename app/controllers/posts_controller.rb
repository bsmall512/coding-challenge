class PostsController < ApplicationController
  def index
    # Return all `Post`
    @posts = if params[:term]
      Post.where('title LIKE ?', "%#{params[:term]}%") 
    else
      @posts = Post.all.order("created_at DESC")
    end
  end

  def new
    # Return view to create a new Post
    @post = Post.new
  end

  def create
    # Add a new `Post` to the database
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def destroy
    # Remove a `Post` from the database
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id]);
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def search_params
    params.require(:post).permit(:title, :body)
  end 

  def term_params
    params.require(:term).permit(:term);
  end
end
