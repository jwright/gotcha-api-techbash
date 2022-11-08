defmodule GotchaWeb.GraphQL.Requests.NearbyArenasTest do
  use GotchaWeb.ConnCase, async: true

  import Gotcha.Factory
  import GotchaWeb.GraphQLHelpers

  describe "with a valid query" do
    setup do
      query = """
      {
        arenas(latitude: 40.7, longitude: -74.0) {
          location_name
        }
      }
      """

      conn = build_conn() |> put_graphql_headers()

      insert(:arena, location_name: "New York Stock Exchange", latitude: 40.76, longitude: -74.0)
      insert(:arena, location_name: "One World Trade Center", latitude: 40.74, longitude: -74.02)

      [conn: conn, query: query]
    end

    test "returns the arenas within the default radius", %{conn: conn, query: query} do
      conn = conn |> post("/graphql", query)

      assert json_response(conn, 200) == %{
               "data" => %{
                 "arenas" => [
                   %{"location_name" => "New York Stock Exchange"},
                   %{"location_name" => "One World Trade Center"}
                 ]
               }
             }
    end
  end
end
