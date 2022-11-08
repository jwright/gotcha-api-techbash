defmodule GotchaWeb.GraphQLHelpers do
  import Plug.Conn

  def put_graphql_headers(conn) do
    conn
    |> put_req_header("content-type", "application/graphql")
  end
end
