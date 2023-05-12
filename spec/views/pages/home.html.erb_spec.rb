# spec/views/domains_spec.rb
require 'rails_helper'

RSpec.describe 'pages/home', type: :view do

  let(:sorted_website_names_with_tags) { FactoryBot.create(:sorted_website_names_with_tags) }

  before do
    assign(:sorted_website_names_with_tags, sorted_website_names_with_tags)
  end

  it "renders the page title" do
    assign(:sorted_website_names_with_tags, sorted_website_names_with_tags)
    render template: 'pages/home'

    expect(rendered).to have_content("Domains Count with Tags")
  end


  it 'renders the table headers' do
    render template: 'pages/home'

    expect(rendered).to have_css('th', text: "Url's (#{sorted_website_names_with_tags.size})")
    expect(rendered).to have_css('th', text: 'Count')
    expect(rendered).to have_css('th', text: 'Tags')
    expect(rendered).to have_css('th', text: 'Description')
  end

  it 'renders the website names' do
    render template: 'pages/home'

    expect(rendered).to have_css('td', text: 'example.com')
    expect(rendered).to have_css('td', text: 'example2.com')
  end

  it 'renders the tag counts' do
    render template: 'pages/home'

    expect(rendered).to have_css('td', text: '2')
    expect(rendered).to have_css('td', text: '1')
  end

  it 'renders the tags' do
    render template: 'pages/home'

    expect(rendered).to have_css('td', text: 'tag1')
    expect(rendered).to have_css('td', text: 'tag2')
    expect(rendered).to have_css('td', text: 'tag3')
  end

  it 'renders the descriptions' do
    render template: 'pages/home'

    expect(rendered).to have_css('td', text: 'Sample description')
    expect(rendered).to have_css('td', text: 'Sample description 2')
  end
end
