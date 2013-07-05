include Warden::Test::Helpers

module LoginHarness

  def login_as_user
    given(:user)  { FactoryGirl.create(:user) }

    background do
      Warden.test_mode!
      login_as(user, scope: :user)
    end

    after :each do
      Warden.test_reset!
    end
  end

end
