defmodule Gotcha.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :avatar, :string
      add :email_address, :string
      add :name, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:players, [:email_address])
  end
end
