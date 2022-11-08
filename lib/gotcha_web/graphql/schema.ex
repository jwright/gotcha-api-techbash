defmodule GotchaWeb.GraphQL.Schema do
  use Absinthe.Schema

  import_types(GotchaWeb.GraphQL.Schema.Types)

  @desc "All queries that can be performed on Gotcha"
  query do
    @desc "Arenas that are nearby to a given location."
    field :arenas, list_of(:arena) do
      arg(:latitude, non_null(:float), description: "The latitude to use for the location")
      arg(:longitude, non_null(:float))
      arg(:radius, :integer, default_value: 25)

      resolve(&GotchaWeb.GraphQL.Resolvers.Arenas.nearby/3)
    end
  end

  @desc "All mutations that can be performed on Gotcha"
  mutation do
    field :register_player, type: :player do
      arg(:avatar, :string)
      arg(:email_address, non_null(:string))
      arg(:name, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&GotchaWeb.GraphQL.Resolvers.Players.register/3)
    end
  end
end
