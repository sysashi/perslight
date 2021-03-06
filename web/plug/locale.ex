defmodule PL.Plug.Locale do
  import Plug.Conn

  def init(opts), do: opts

  # FIXME
  def call(conn, _opts) do
    cond do
      l = locale_from_session(conn) -> set_locale(l)
      l = locale_from_params(conn) -> set_locale(l)
      l = locale_from_header(conn) -> set_locale(l)
      false -> set_locale("en")
    end
    conn
  end

  defp locale_from_session(conn) do
    get_session(conn, :locale)
  end

  defp locale_from_header(conn) do
    case get_req_header(conn, "accept-language") do
      [locale_string | _] ->
        String.split(locale_string, ",")
        |> Enum.map(fn locale ->
          String.split(locale, ";") |> List.first
        end)
    end
    |> Enum.filter(fn l -> l in available_locales() end)
  end

  defp locale_from_params(conn) do
    if locale = conn.params["locale"] do
      locale
    end
  end

  # FIXME
  defp set_locale([]) do
    available_locales() |> List.first |> set_locale
  end

  defp set_locale([l | _]) do
    set_locale(l)
  end

  defp set_locale(l) when is_binary(l) and l in ~w(en ru) do
    Gettext.put_locale(PL.Gettext, l)
  end

  defp available_locales do
    Gettext.known_locales(PL.Gettext)
  end
end
