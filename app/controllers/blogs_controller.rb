# frozen_string_literal: true

class BlogsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  before_action :set_blog, only: %i[show edit update destroy]

  def index
    @blogs = Blog.search(params[:term]).published.default_order
  end

  def show
    render file: 'public/404.html' if @blog.secret? && !@blog.owned_by?(current_user)
  end

  def new
    @blog = Blog.new
  end

  def edit
    redirect_to blog_url(@blog) if !@blog.owned_by?(current_user)
  end

  def create
    @blog = current_user.blogs.new(check_and_override(blog_params))

    if @blog.save
      redirect_to blog_url(@blog), notice: 'Blog was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @blog.update(check_and_override(blog_params))
      redirect_to blog_url(@blog), notice: 'Blog was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy!

    redirect_to blogs_url, notice: 'Blog was successfully destroyed.', status: :see_other
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :content, :secret, :random_eyecatch)
  end

  def check_and_override(params)
    params[:random_eyecatch] = '0' if !current_user.premium? && params[:random_eyecatch]&.==('1')
    params
  end
end
