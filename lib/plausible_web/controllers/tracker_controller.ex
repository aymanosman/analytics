defmodule PlausibleWeb.TrackerController do
  use PlausibleWeb, :controller
  require EEx
  EEx.function_from_file(:defp, :render_plausible, Application.app_dir(:plausible, "priv/tracker/js/plausible.js"), [:base_url])
  EEx.function_from_file(:defp, :render_p, Application.app_dir(:plausible, "priv/tracker/js/p.js"), [:base_url])
  @max_age 3600 # 1 hour

  def plausible(conn, _params) do
    conn
    |> put_resp_header("cache-control", "max-age=#{@max_age},public")
    |> send_resp(200, render_plausible(base_url()))
  end

  def analytics(conn, _params) do
    conn
    |> put_resp_header("cache-control", "max-age=#{@max_age},public")
    |> send_resp(200, render_plausible(base_url()))
  end

  def p(conn, _params) do
    conn
    |> put_resp_header("cache-control", "max-age=#{@max_age},public")
    |> send_resp(200, render_p(base_url()))
  end

  defp base_url() do
    PlausibleWeb.Endpoint.clean_url()
  end
end
