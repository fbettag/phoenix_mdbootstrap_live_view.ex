defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>Live.Index do
  use <%= inspect context.web_module %>, :live_view

  alias <%= inspect context.module %>
  alias <%= inspect schema.module %>

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(<%= inspect context.base_module %>.PubSub, "<%= schema.collection %>")
    {:ok, assign(socket, :<%= schema.collection %>, list_<%= schema.plural %>(socket)), temporary_assigns: [<%= schema.collection %>: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, gettext("Edit %{model}", model: gettext("<%= schema.human_singular %>")))
    |> assign(:<%= schema.singular %>, <%= inspect context.alias %>.get_<%= schema.singular %>!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, gettext("New %{model}", model: gettext("<%= schema.human_singular %>")))
    |> assign(:<%= schema.singular %>, %<%= inspect schema.alias %>{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, gettext("Listing %{model}", model: gettext("<%= schema.human_plural %>")))
    |> assign(:<%= schema.singular %>, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    <%= schema.singular %> = <%= inspect context.alias %>.get_<%= schema.singular %>!(id)
    {:ok, _} = <%= inspect context.alias %>.delete_<%= schema.singular %>(<%= schema.singular %>)

    {:noreply, assign(socket, :<%= schema.collection %>, list_<%=schema.plural %>(socket))}
  end

  @impl true
  def handle_info({:<%= schema.singular %>_created, <%= schema.singular %>}, socket) do
    {:noreply, update(socket, :<%= schema.collection %>, fn <%= schema.collection %> -> [<%= schema.singular %> | <%= schema.collection %>] end)}
  end

  @impl true
  def handle_info({:<%= schema.singular %>_updated, <%= schema.singular %>}, socket) do
    {:noreply, update(socket, :<%= schema.collection %>, fn <%= schema.collection %> -> [<%= schema.singular %> | <%= schema.collection %>] end)}
  end

  defp list_<%= schema.plural %>(_socket) do
    <%= inspect context.alias %>.list_<%= schema.plural %>()
  end
end
