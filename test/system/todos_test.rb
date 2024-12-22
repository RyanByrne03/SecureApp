require "application_system_test_case"

class TodosTest < ApplicationSystemTestCase
  setup do
    @todo = todos(:one)
  end

  test "visiting the index" do
    visit todos_url
    assert_selector "h1", text: "To-Do List"
  end

  test "should create to-do" do
    visit todos_url
    click_on "New To-Do"

    check "Completed" if @todo.completed
    fill_in "Description", with: @todo.description
    fill_in "Title", with: @todo.title
    click_on "Create Todo"

    assert_text "To-do was successfully created"
    click_on "Back to todos"
  end

  test "should update To-do" do
    visit todo_url(@todo)
    click_on "Edit this to-do", match: :first

    check "Completed" if @todo.completed
    fill_in "Description", with: @todo.description
    fill_in "Title", with: @todo.title
    click_on "Update Todo"

    assert_text "To-do was successfully updated"
    click_on "Back to todos"
  end

  test "should destroy To-do" do
    visit todo_url(@todo)
    click_on "Destroy this todo", match: :first

    assert_selector "h1", text: "To-Do List"
  end
end
