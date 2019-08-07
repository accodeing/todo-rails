ParameterType(
  name:        'symbol',
  regexp:      /\w+/,
  type:        Symbol,
  transformer: ->(s) { s.to_sym }
)

BASE_URL = 'http://localhost:3000'
PAGES = {
  front: '/',
  new_list_page: '/todo_lists/new',
  list: '/todo_lists'
}

def fill_in_title(title)
  fill_in 'Title', with: title
end

def fill_in_description(description)
  fill_in 'Description', with: description
end

Given('I am on the {symbol} page') do |page|
  visit BASE_URL + PAGES.fetch( page, '/' )
end

When('I initiate a new list') do
  click_link('New Todo List')
end

Then('I navigate to the new list page') do
  expect(page).to have_current_path(PAGES.fetch(:new_list_page))
end

Given('I am on the new list page') do
  visit BASE_URL + PAGES.fetch( :new_list_page )
end

When("I enter the title {string}") do |string|
  fill_in_title(string)
end

And('I enter the description {string}') do |description|
  fill_in_description(description)
end

And('I create a new list') do
  click_button('Create Todo list')
end

Then('a new list is {word} created') do |maybe|
  success_message = 'Todo list was successfully created.'

  if maybe == 'successfully'
    expect(page).to have_content(success_message)
  else
    expect(page).not_to have_content(success_message)
  end
end

And('the page contains {string}') do |string|
  expect(page).to have_content(/#{string}/i)
end

When("I edit the existing list {string}") do |list_title|
  @existing_title = list_title
  click_link(@existing_title)
  click_link('Edit')
  fill_in_title('An updated title')
end

And('I change {word} to {string}') do |type, new_text|
  if type == 'title'
    fill_in_title(new_text)
  elsif type == 'description'
    fill_in_title(new_text)
  end
end

And('I update the list') do
  click_button('Update Todo list')
end

Then('the list is {word} updated') do |maybe|
  success_message = 'Todo list was successfully updated'

  if maybe == 'successfully'
    expect(page).to have_content(success_message)
  else
    expect(page).not_to have_content(success_message)
  end
end

When('I delete the list {string} and {word} the deletion') do |list_title, affirmation|
  click_link(list_title)
  if affirmation == 'accept'
    accept_confirm do
      click_link('Delete')
    end
  else
    dismiss_confirm do
      click_link('Delete')
    end
  end
end

Then('I am {word} navigated to the list page') do |maybe|
  if maybe == 'successfully'
    expect(page).to have_current_path(PAGES.fetch(:list))
  else
    expect(page).not_to have_current_path(PAGES.fetch(:list))
  end
end

And('the list {string} is {word} deleted') do |list_title, maybe|
  if maybe == 'successfully'
    expect(page).not_to have_content(/#{list_title}/i)
  else
    expect(page).to have_content(/#{list_title}/i)
  end
end
