defmodule Chat do

  def receive_msg(msg) do
    IO.puts msg
  end

  def receive_msg_for_toast(msg, from) do
    IO.puts msg
    send_msg(from, "eat?")
  end

  def send_msg(:toast@localhost, msg) do
    remote_supervisor(:toast@localhost)
    |> Task.Supervisor.async(__MODULE__, :receive_msg_for_toast, [msg, Node.self()])
    |> Task.await()
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
