Given 'I go to comparisons' do
  visit root_path
  click_on 'Comparison'
end

Then 'I see {string}' do |string|
  expect(page).to have_text(string)
end

Then 'I go to {string}' do |string|
  click_on string
end
