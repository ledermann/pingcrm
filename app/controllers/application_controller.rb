class ApplicationController < ActionController::Base
  include Pagy::Backend
  inertia_share do
    {
      flash: [],
      errors: [],
      auth: {
        user: {
          id: 1,
          name: "john",
          first_name: 'John',
          last_name: 'Doe',
          role: 'Admin',
          account: {
            id: 1,
            name: 'Acme Corporation'
          }
        }
      }
    }
  end
end
