defmodule Survey.ScenarioProvider do
  def get_scenario("survey0" = _scenario_name) do
    # we won't store it in db yet
    %{
      steps: [
        %{
          name: "step-1",
          title: "Step 1/4: Hey! Please give your name",
          inputs: [
            %{
              name: "first_name",
              type: "text",
              question: "What is your first name?",
              label: "First name",
              placeholder: "John",
              validations: [
                {:min_length, 3},
                {:max_length, 30}
              ]
            },
            %{
              name: "last_name",
              type: "text",
              question: "What is your last name?",
              label: "Last name",
              placeholder: "Doe",
              validations: [
                :required,
                {:min_length, 3},
                {:max_length, 30}
              ]
            }
          ]
        },
        %{
          name: "step-2",
          title: "Step 2/4: Email",
          inputs: [
            %{
              name: "email",
              type: "text",
              style: "email",
              question: "What is your email?",
              label: "Email",
              placeholder: "some@example.org",
              validations: [
                :required
              ]
            },
            %{
              name: "comment",
              type: "text",
              style: "textarea",
              question: "Leave a comment",
              label: "Comment",
              placeholder: "Please write comment here"
            }
          ]
        },
        %{
          name: "step-3",
          title: "Step 3/4: Measures",
          inputs: [
            %{
              name: "height",
              type: "text",
              style: "number",
              question: "What is your height in cm?",
              label: "Height",
              placeholder: "172",
              validations: [
                {:min_value, 30},
                {:max_value, 250}
              ]
            },
            %{
              name: "weight",
              type: "text",
              style: "number",
              question: "What is your weight in kg?",
              label: "Weight",
              placeholder: "68",
              validations: [
                :required,
                {:min_value, 1},
                {:max_value, 300}
              ]
            }
          ]
        },
        %{
          name: "step-4",
          title: "Step 4/4: Insurance",
          inputs: [
            %{
              name: "insurance",
              type: "select",
              question: "What is your insurance?",
              label: "insurance",
              options: [
                %{
                  title: "Kaiser Permanente",
                  value: "kaiser"
                },
                %{
                  title: "Elevance Health (Anthem)",
                  value: "anthem"
                },
                %{
                  title: "UnitedHealth Group",
                  value: "united"
                }
              ]
            }
          ]
        },
        %{
          name: "step-5",
          title: "Congratulations! You've finished survey",
          final: true
        }
      ]
    }
  end
end
