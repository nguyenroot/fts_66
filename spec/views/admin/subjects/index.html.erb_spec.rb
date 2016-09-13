require "rails_helper"

RSpec.describe "admin/subjects/index", type: :view do
  let(:admin) {FactoryGirl.create :user, :admin}
  before {sign_in admin}

  let(:firstSubject) do
    mock_model Subject, name: "First", question_number: 1, duration: 10
  end
  let(:secondSubject) do
    mock_model Subject, name: "Second", question_number: 2, duration: 20
  end

  it "displays users correctly" do
    assign :subjects, Kaminari.paginate_array([firstSubject, secondSubject]).page(1)
    render
    expect(rendered).to include("First")
    expect(rendered).to include("Second")
  end
end
