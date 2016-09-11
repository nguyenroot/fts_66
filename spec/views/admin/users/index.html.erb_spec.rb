require "rails_helper"

RSpec.describe "admin/users/index", type: :view do
  let(:admin) {FactoryGirl.create :user, :admin}
  let(:user) {FactoryGirl.create :user}
  before {sign_in admin}

  it "displays users correctly" do
    assign :users, Kaminari.paginate_array([admin, user]).page(1)

    render

    expect(rendered).to include(admin.name)
    expect(rendered).to include(admin.email)
    expect(rendered).to include(user.name)
    expect(rendered).to include(user.email)
  end
end
