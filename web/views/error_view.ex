defmodule PL.ErrorView do
  use PL.Web, :view

  def render("404.html", assigns) do
    render_error 404, "Not Found", assigns
  end

  def render("500.html", assigns) do
    render_error 500, "Internal Server Error", assigns
  end

  defp render_error(status, message, assigns) do
    render PL.LayoutView, "error.html",
      message: message,
      status: status,
      conn: assigns.conn
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.html", assigns
  end
end
