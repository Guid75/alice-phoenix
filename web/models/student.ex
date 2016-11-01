defmodule Alice.Student do
  use Alice.Web, :model

  schema "students" do
    field :firstName, :string
    field :lastName, :string
	belongs_to :formation, Alice.Formation

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:firstName, :lastName])
    |> validate_required([:firstName, :lastName])
  end
end
