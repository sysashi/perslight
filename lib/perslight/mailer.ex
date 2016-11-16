defmodule PL.Mailer do
  alias SendGrid.{Mailer, Email}

  def send_message(message_body) when is_binary(message_body) do
    receiver = Application.get_env(:sendgrid, :receiver)

    email =
      Email.build()
      |> Email.put_from("perslight@admin.com")
      |> Email.add_to(receiver)
      |> Email.put_subject("New message from your website!")
      |> Email.put_text(message_body)

    Mailer.send(email)
  end
end
