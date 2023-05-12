class PagesController < ApplicationController
  def home
    @bookmarks = Bookmark.all

    domains_with_tags_and_description
    tags_count_with_description
    return @sorted_tags_count_with_description = sorted_tags&.reverse! if direction == "desc"

    @sorted_tags_count_with_description = sorted_tags
  end

  def modal_content
    @bookmark = Bookmark.all
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  def domains_with_tags_and_description
    @bookmarks.map do |bookmark|
      url = bookmark.href
      website_name = url.sub(%r{^https?://(www\.)?}, '').split('/').first
      { website_name: website_name, tags: bookmark.tags, description: bookmark.description }
    end
  end

  def tags_count_with_description
    domains_with_tags_and_description.group_by { |entry| entry[:website_name] }.transform_values do |entries|
      tags_tally = entries.flat_map { |entry| entry[:tags] }.tally
      descriptions = entries.map { |entry| entry[:description] }.uniq
      { tags: tags_tally, descriptions: descriptions }
    end
  end

  def sorted_tags
    case column
    when 'website_name'
      tags_count_with_description.sort_by { |website_name, _| website_name }
    when 'count'
      tags_count_with_description.sort_by { |_, data| data[:tags].values.sum }
    when 'tags'
      tags_count_with_description.sort_by { |_, data| data[:tags].keys }
    else
      tags_count_with_description
    end
  end

  def column
    params[:sort_by] || "website_name"
  end

  def direction
    params[:direction] || "asc"
  end

  # TODO: Safe params
  def page_params
    # params.require(:page).permit(:href, :description, :extended, :meta, :hash_value, :shared, :toread, :tags[])
  end
end
