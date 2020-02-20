defmodule TurnifyWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :calendar, :calendar
  end

  object :calendar do
    field :id, non_null(:id)
  end

  object :company do
    field :id, non_null(:id)
    field :name, non_null(:string)
  end

  object :sign_in do
    field :token, :string
  end
end
