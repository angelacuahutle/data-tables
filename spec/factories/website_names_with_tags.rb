# spec/factories/website_names_with_tags.rb
FactoryBot.define do
  factory :sorted_tags_count_with_description, class: Hash do
    skip_create

    initialize_with do
      {
        'example.com' => {
          tags: { 'tag1' => 1, 'tag2' => 1 },
          descriptions: ['Sample description']
        },
        'example2.com' => {
          tags: { 'tag3' => 1 },
          descriptions: ['Sample description 2']
        }
      }
    end
  end
end
