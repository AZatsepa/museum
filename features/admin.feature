@javascript
  Feature: Admin
    As user
    I want to manage posts

    Scenario: I See admin
      Given I have post and go to admin
      Then I see posts

    Scenario: I manage post
      Given I have post and go to admin
      Then I create new post
      And I see posts
      Then I go to post
      And I edit post
      Then I go to posts
      And I delete post
