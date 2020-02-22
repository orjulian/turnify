defmodule TurnifyWeb.Schema do
  use Absinthe.Schema
  import_types(TurnifyWeb.Schema.ContentTypes)

  alias TurnifyWeb.Resolvers

  query do
    @desc "Get user by id"
    field :fetch_user, :user do
      arg(:id, non_null(:integer))

      resolve(&Resolvers.User.fetch_user/3)
    end
  end

  mutation do
    @desc "Sign in User"
    field :sign_in, :sign_in do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&Resolvers.User.sign_in/3)
    end

    @desc "Create User"
    field :create_user, :user do
      arg(:password, non_null(:string))
      arg(:password_confirmation, non_null(:string))
      arg(:email, non_null(:string))
      arg(:role, non_null(:string))

      resolve(&Resolvers.User.create_user/3)
    end

    @desc "Create company"
    field :create_company, :company do
      arg(:name, non_null(:string))

      resolve(&Resolvers.Company.create_company/3)
    end
  end
end
