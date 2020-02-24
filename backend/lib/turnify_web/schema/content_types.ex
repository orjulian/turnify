defmodule TurnifyWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  object :user do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :calendar, :calendar
  end

  object :company do
    field :id, non_null(:id)
    field :name, non_null(:string)
  end

  object :calendar do
    field :id, non_null(:id)
  end

  object :available_day do
    field :day, non_null(:string)
    field :hours, list_of(non_null(:string))
  end

  object :sign_in do
    field :token, :string
  end

  input_object :time_range do
    field :hour_from, non_null(:string)
    field :hour_to, non_null(:string)
    field :minutes_span, non_null(:integer)
  end
end
