defmodule Chat do

  def receive_msg(msg) do
    IO.puts msg
  end

  def send_msg(node, msg) do
    node
    |> remote_supervisor()
    |> Task.Supervisor.async(__MODULE__, :receive_msg, [msg])
    |> Task.await()
  end

  def remote_supervisor(node) do
    {Chat.TaskSupervisor, node}
  end

  def test do
    IO.puts "hello, world!"
  end
end
