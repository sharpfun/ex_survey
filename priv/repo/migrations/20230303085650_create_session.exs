defmodule Survey.Repo.Migrations.CreateSession do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :scenario_name, :string, null: false
      add :step_idx, :integer, null: false
      add :data, :map

      timestamps()
    end
  end
end
