defmodule Survey.SessionManager.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: true}

  schema "sessions" do
    field(:scenario_name, :string)
    field(:step_idx, :integer, default: 0)
    field(:data, :map)

    timestamps()
  end

  def changeset(%__MODULE__{} = session, attrs) do
    session
    |> cast(attrs, [:scenario_name, :step_idx, :data])
    |> validate_required([:scenario_name, :step_idx, :data])
  end
end
