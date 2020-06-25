defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>Live.Show do
  use <%= inspect context.web_module %>, :live_view

  alias <%= inspect context.module %>

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(<%= inspect context.base_module %>.PubSub, "<%= schema.singular %>:" <> id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:<%= schema.singular %>, <%= inspect context.alias %>.get_<%= schema.singular %>!(id))}
  end

  @impl true
  def handle_info({:<%= schema.singular %>_updated, <%= schema.singular %>}, socket) do
    {:noreply, update(socket, :<%= schema.singular %>, <%= schema.singular %>)}
  end

  defp page_title(:show), do: gettext("Show %{model}", model: gettext("<%= schema.human_singular %>"))
  defp page_title(:edit), do: gettext("Edit %{model}", model: gettext("<%= schema.human_singular %>"))
end
