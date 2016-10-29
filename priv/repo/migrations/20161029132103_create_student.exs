defmodule Alice.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :firstName, :string
      add :lastName, :string

      timestamps()
    end

  end
end
