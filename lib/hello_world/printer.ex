defmodule HelloWorld.Printer do
  use GenServer

  def start_link(state, opts \\ []) do
    {:ok, pid} = GenServer.start_link(__MODULE__, state, opts)
    Process.send_after(pid, :print , 5_000)
    {:ok, pid}
  end

  def print(pid, message) do
    GenServer.cast pid, {:print, message}
  end
  
  def handle_cast({:print, message}, state) do
    IO.puts message
    {:noreply, state}
  end

  def handle_info(:print, state) do
    GenServer.cast self(), {:print, "Hello test"}
    Process.send_after(self(), :print ,5_000)
    {:noreply, state}
  end
end
