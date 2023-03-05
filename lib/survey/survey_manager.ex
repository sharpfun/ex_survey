defmodule Survey.SurveyManager do
  alias Survey.SessionManager
  alias Survey.ScenarioProvider

  def start(scenario_name) do
    session = SessionManager.create_session(scenario_name, %{})
    scenario = ScenarioProvider.get_scenario(scenario_name)

    %{
      session_id: session.uuid,
      step: get_step(scenario, session.step_idx)
    }
  end

  def continue(session_id, step_data) do
    session = SessionManager.get_session!(session_id)
    scenario_name = session.scenario_name
    scenario = ScenarioProvider.get_scenario(scenario_name)
    step_idx = session.step_idx
    current_step = get_step(scenario, step_idx)

    case validate_step_data(current_step, step_data) do
      :ok ->
        step_idx = step_idx + 1
        data = Map.put(session.data, current_step.name, step_data)
        SessionManager.put_session!(session_id, step_idx, data)
        step = get_step(scenario, step_idx)

        if Map.get(step, :final, false) do
          IO.inspect(SessionManager.get_session!(session_id), label: "SESSION")
        end

        step

      {:error, step} ->
        step
    end
  end

  defp get_step(scenario, step_idx) do
    Enum.at(scenario.steps, step_idx)
  end

  defp validate_step_data(step, step_data) do
    # step_data
    # %{"first_name" => "Max", "last_name" => "Mustermann"}
    inputs =
      for input <- Map.get(step, :inputs, []) do
        value = Map.get(step_data, input.name)

        errors =
          for validation <- Map.get(input, :validations, []) do
            if value in ["", nil] do
              if validation == :required, do: "#{input.label} is required"
            else
              case validation do
                :required ->
                  nil

                {:min_length, min_length} ->
                  if String.length(value) < min_length,
                    do: "#{input.label} minimal length is #{min_length}"

                {:max_length, max_length} ->
                  if String.length(value) > max_length,
                    do: "#{input.label} maximal length is #{max_length}"

                {:min_value, min_value} ->
                  if String.to_integer(value) < min_value,
                    do: "#{input.label} minimal value is #{min_value}"

                {:max_value, max_value} ->
                  if String.to_integer(value) > max_value,
                    do: "#{input.label} maximal value is #{max_value}"
              end
            end
          end
          |> Enum.reject(&is_nil/1)

        input
        |> Map.put(:errors, errors)
        |> Map.put(:value, value)
      end

    if Enum.flat_map(inputs, & &1.errors) |> Enum.any?() do
      {:error, %{step | inputs: inputs}}
    else
      :ok
    end
  end
end
