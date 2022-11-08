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
end
