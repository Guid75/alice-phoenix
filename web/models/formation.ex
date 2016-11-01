defmodule Alice.Formation do
  use Alice.Web, :model

  schema "formations" do
    field :title, :string
	has_many :students, Alice.Student

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
