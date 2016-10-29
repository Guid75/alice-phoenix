defmodule Alice.Teacher do
  use Alice.Web, :model

  schema "teachers" do
    field :firstName, :string
    field :lastName, :string

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
