defmodule Alice.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :firstName, :string
      add :lastName, :string
	  add :formation_id, references(:formations)

      timestamps()
    end

  end
end
