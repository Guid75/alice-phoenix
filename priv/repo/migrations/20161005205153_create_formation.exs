defmodule Alice.Repo.Migrations.CreateFormation do
  use Ecto.Migration

  def change do
    create table(:formations) do
      add :title, :string

      timestamps()
    end

  end
end
