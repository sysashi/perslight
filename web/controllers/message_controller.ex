defmodule PL.MessageController do
  use PL.Web, :controller

  def new(conn, _params) do
   render conn, "new.html"
  end

  def success(conn, _params) do
    render conn, "success.html"
  end

  def create(conn, %{"message" => %{"message_body" => msg}, "g-recaptcha-response" => grr}) do
    if grr != "" and check_grr(grr, conn.remote_ip |> :inet.ntoa |> List.to_string) do
      PL.Mailer.send_message(msg)
      redirect conn, to: message_path(conn, :success)
    else
      conn
      |> put_flash(:error, "Invalide recaptcha")
      |> redirect(to: message_path(conn, :new))
    end
  end

  defp check_grr(grr, user_ip) when is_binary(user_ip) and is_binary(grr) do
    url = "https://www.google.com/recaptcha/api/siteverify"
    secret = Application.get_env(:perslight, PL.Endpoint)[:recaptcha_key]

    headers = [
      "Content-type": "application/x-www-form-urlencoded",
      "User-agent": "perslight"
    ]

    payload = %{
      "secret" => secret,
      "response" => grr,
      "remoteip" => user_ip
    } |> URI.encode_query

    case HTTPoison.post(url, payload, headers) do
      {:ok, %HTTPoison.Response{body: body}} -> check_recaptcha_response(body)
      _ -> false
    end
  end

  defp check_recaptcha_response(response) do
    Poison.decode!(response)["success"]
  end
end
