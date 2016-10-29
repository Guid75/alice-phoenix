defmodule Alice.Repo.Migrations.CreateTeacher do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :firstName, :string
      add :lastName, :string

      timestamps()
    end

  end
end
