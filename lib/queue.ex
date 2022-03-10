defmodule Queue do
  @moduledoc """
  This module implements a queue data structure using genserver.
  """
  use GenServer

  @doc """
  Starts a queue server.

  ## Example:

  iex> initial_state = [1, 2, 3]
  [1, 2, 3]
  iex> {:ok, pid} = Queue.start_link(initial_state)
  iex> Queue.enqueue(pid, 4)
  :ok
  iex> Queue.dequeue(pid)
  1
  """
  @spec start_link(initial_state :: list()) :: {:ok, any()}
  def start_link(initial_state) when is_list(initial_state) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  @doc false
  def enqueue(pid, element), do: GenServer.cast(pid, {:push, element})

  @doc false
  def dequeue(pid), do: GenServer.call(pid, :pop)

  @impl true
  def init(queue) do
    {:ok, queue}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:push, element}, queue) do
    {:noreply, queue ++ [element]}
  end
end
