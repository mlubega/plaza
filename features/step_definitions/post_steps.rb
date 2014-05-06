Given(/^a user visit the new post page$/) do
  visit signin_path
  click_link "Sign in"
  @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
  visit new_post_path
end

Given(/^the title is not blank$/) do
  fill_in "Title", with: "my title"
end

Given(/^the content is not blank$/) do
  fill_in "Content", with: "my content"
end

Given(/^the user click on post button$/) do
  click_button "Post!"
end

Then(/^he should see the posts list$/) do
  expect(page).to have_content('Posts List') 
end