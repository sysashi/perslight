defmodule PL.LayoutView do
  use PL.Web, :view

  def current_locale do
    Gettext.get_locale(PL.Gettext)
  end

  def resume_link("en") do
    "/resume/resume_en.pdf"
  end

  def resume_link("ru") do
    "/resume/resume_ru.pdf"
  end

  def resume_link(_) do
    resume_link("en")
  end
end
