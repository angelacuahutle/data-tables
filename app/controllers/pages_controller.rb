class PagesController < ApplicationController
  def home
    sort_column = params[:sort_by] || "website_name"
    sort_direction = params[:direction] || "asc"

    bookmarks = Bookmark.all

    website_names_with_tags = bookmarks.map do |bookmark|
      url = bookmark.href
      website_name = url.sub(%r{^https?://(www\.)?}, '').split('/').first
      { website_name: website_name, tags: bookmark.tags, description: bookmark.description }
    end

    @sorted_website_names_with_tags = website_names_with_tags.group_by { |entry| entry[:website_name] }.transform_values do |entries|
      tags_tally = entries.flat_map { |entry| entry[:tags] }.tally
      descriptions = entries.map { |entry| entry[:description] }.uniq
      { tags: tags_tally, descriptions: descriptions }
    end

    @sorted_website_names_with_tags = case sort_column
    when 'website_name'
      @sorted_website_names_with_tags.sort_by { |website_name, _| website_name }
    when 'count'
      @sorted_website_names_with_tags.sort_by { |_, data| data[:tags].values.sum }
    when 'tags'
      @sorted_website_names_with_tags.sort_by { |_, data| data[:tags].keys }
    end

    @sorted_website_names_with_tags = @sorted_website_names_with_tags.reverse! if sort_direction == "desc"
  end
end
