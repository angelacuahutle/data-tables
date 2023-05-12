class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[show edit update destroy]

  # GET /bookmarks or /bookmarks.json
  def index
    @bookmarks = Bookmark.all
  end

  # GET /bookmarks/1 or /bookmarks/1.json
  def show; end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end

  # GET /bookmarks/1/edit
  def edit; end

  # POST /bookmarks or /bookmarks.json
  def create
    @bookmark = Bookmark.new(bookmark_params)

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to bookmark_url(@bookmark), notice: 'Bookmark was successfully created.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookmarks/1 or /bookmarks/1.json
  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to bookmark_url(@bookmark), notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1 or /bookmarks/1.json
  def destroy
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def tables
    bookmarks = JSON.parse(File.read('ruby_bookmarks.json'))
    @tags = tags_count_data(bookmarks)
    @bookmarks_time = Bookmark.all.group_by_day(:created_at).count
  end

  private

  def tags_count_data(bookmarks)
    tags_counts = {}
    bookmarks.each do |bookmark|
      tags = bookmark['tags'].split
      tags.each do |tag|
        tags_counts[tag] ||= 0
        tags_counts[tag] += 1
      end
    end
    tags_counts
  end

  # Use callbacks to share common setup or constraints between actions.

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmarks_over_time
    @bookmarks_time = Bookmark.group_by_day(:created_at).count
  end

  # Only allow a list of trusted parameters through.

  def bookmark_params
    params.require(:bookmark).permit(:href, :description, :extended, :meta, :hash_value, :shared, :toread, :tags)
  end
end
