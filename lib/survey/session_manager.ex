defmodule Survey.SessionManager do
  alias Survey.Repo
  alias Survey.SessionManager.Session

  def create_session(scenario_name, data) do
    %Session{}
    |> Session.changeset(%{scenario_name: scenario_name, step_idx: 0, data: data})
    |> Repo.insert!()
  end

  def put_session!(session_id, step_idx, data) do
    Repo.get!(Session, session_id)
    |> Session.changeset(%{step_idx: step_idx, data: data})
    |> Repo.update!()
  end

  def get_session!(session_id) do
    Repo.get!(Session, session_id)
  end
end
