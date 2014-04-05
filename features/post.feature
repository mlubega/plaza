 Feature: Post
 
 Scenario: Post
   Given a user visit the new post page
   And   the title is not blank
   And   the content is not blank
   And   the user click on post button
   Then  he should see the posts list