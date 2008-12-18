# feature tests for Tables
# revision: $Revision: 1.0 $

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..') unless $SETUP_LOADED
require 'unittests/setup'

class TC_TableBody < Test::Unit::TestCase
  def setup
    goto_page("table_bodies.html")
  end

  #TODO: These tests should be rewritten using mocks.
  #I do not know which mock framework to use in FireWatir, so will do it later

  def test_get_collection_jssh_names
    table = browser.table(:id, "table_with_two_bodies")
    table.locate

    jssh_names = table.get_collection_jssh_names('tBodies')

    assert_equal 2, jssh_names.length
    assert_equal table.element_name + ".tBodies[0]", jssh_names[0]
    assert_equal table.element_name + ".tBodies[1]", jssh_names[1]
  end

  def test_get_collection_length
    table_with_one_body = browser.table(:id, "table_with_one_body")
    table_with_one_body.locate

    assert_equal 1, table_with_one_body.get_collection_length('tBodies')

    table_with_two_bodies = browser.table(:id, "table_with_two_bodies")
    table_with_two_bodies.locate

    assert_equal 2, table_with_two_bodies.get_collection_length('tBodies')
  end


  def test_finds_rows_in_single_body
    table_with_one_body = browser.table(:id, "table_with_one_body")
    body = table_with_one_body.bodies[0]

    assert_equal 2, body.rows.length
  end

  def test_does_not_mix_rows_between_many_bodies
    table_with_two_bodies = browser.table(:id, "table_with_two_bodies")

    first_body = table_with_two_bodies.bodies[0]
    second_body = table_with_two_bodies.bodies[1]

    assert_equal 2, first_body.rows.length
    assert_equal 1, second_body.rows.length
  end

  def test_returns_empty_array_if_no_rows
    table_with_empty_body = browser.table(:id, "table_with_empty_body")
    body = table_with_empty_body.bodies[0]
    rows = body.rows

    assert_instance_of Array, rows
    assert_equal 0, rows.length
  end

  def test_array_like_access_to_rows
    body = browser.table(:id, "table_with_one_body").bodies[0]
    assert_equal "Row #1", body[1][1].to_s
    assert_equal "Row #2", body[2][1].to_s
  end

  # Mocks would be ideal here
  def test_length
    table = browser.table(:id, "table_with_two_bodies")

    assert_equal table.bodies[0].rows.length, table.bodies[0].length
    assert_equal table.bodies[1].rows.length, table.bodies[1].length
  end


  # Dirty mocks implementation
  FireWatir::TableRow.class_eval do
    @@counter = 0

    def increment_counter
      @@counter += 1
    end

    def self.counter_value
      @@counter
    end
  end

  def test_each
    table = browser.table(:id, "table_with_two_bodies")

    table.bodies[0].each { |row| row.increment_counter }

    assert_equal table.bodies[0].rows.length, FireWatir::TableRow.counter_value
  end

end
