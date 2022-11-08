defmodule Gotcha.Player do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gotcha.Repo

  schema "players" do
    field :avatar, :string
    field :email_address, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def register(params) do
    __MODULE__
    |> changeset(params)
    |> Repo.insert()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :email_address, :avatar, :password])
    |> validate_required([:name, :email_address, :password])
    |> unique_constraint(:email_address)
    |> hash_password
  end

  defp hash_password(%{changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp hash_password(changeset), do: changeset
end
