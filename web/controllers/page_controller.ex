defmodule PL.PageController do
  use PL.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def download_resume(conn, params) do
    current_locale = Gettext.get_locale(PL.Gettext)
    conn
    |> send_file(200, resume_path(current_locale))
    |> redirect(to: page_path(conn, :index))
  end

  # FIXME
  def set_locale(conn, %{"locale" => locale}) when locale in ~w(en ru) do
    redirect_path = origin_referer(conn) || page_path(conn, :index)
    conn
    |> put_session(:locale, locale)
    |> redirect(to: redirect_path)
  end

  # FIXME
  defp resume_path(locale) do
    resume_ru = "priv/resume/ru/resume.pdf"
    resume_en = "priv/resume/en/resume.pdf"
    case locale do
      "en" -> resume_en
      "ru" -> resume_ru
      _ -> resume_en
    end
  end

  def origin_referer(conn) do
    server_url = PL.Endpoint.url()
    referer = get_req_header(conn, "referer") |> List.first
    if referer && String.starts_with?(referer, server_url) do
      URI.parse(referer).path
    end
  end
end
