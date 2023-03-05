defmodule SurveyWeb.Live.Survey do
  use SurveyWeb, :live_view

  alias Survey.SurveyManager

  @impl true
  def mount(_params, _session, socket) do
    scenario_name = "survey0"

    %{
      session_id: session_id,
      step: step
    } = SurveyManager.start(scenario_name)

    socket =
      socket
      |> assign(:session_id, session_id)
      |> assign(:step, step)

    {:ok, socket}
  end

  def handle_event("save", params, socket) do
    step = SurveyManager.continue(socket.assigns.session_id, params)
    {:noreply, assign(socket, :step, step)}
  end
end
