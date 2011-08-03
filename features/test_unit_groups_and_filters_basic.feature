@test_unit
Feature:

  Defining some groups and filters should give a corresponding
  coverage report that respects those settings after running tests

  Scenario:
    Given I cd to "project"
    Given a file named "test/simplecov_config.rb" with:
      """
      require 'simplecov'
      SimpleCov.start do
        add_group 'Libs', 'lib/faked_project/'
        add_filter '/test/'
      end
      """
      
    When I successfully run `bundle exec rake test`
    Then a coverage report should have been generated

    Given I open the coverage report
    Then I should see the groups:
      | name      | coverage | files |
      | All Files | 89.74%   | 4     |
      | Libs      | 87.5%    | 3     |
      | Ungrouped | 100.0%   | 1     |
      
    And I should see the source files:
      | name                                      | coverage |
      | ./lib/faked_project.rb                    | 100.0 %  |
      | ./lib/faked_project/some_class.rb         | 81.82 %  |
      | ./lib/faked_project/framework_specific.rb | 75.0 %   |
      | ./lib/faked_project/meta_magic.rb         | 100.0 %  |