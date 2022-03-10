defmodule QueueTest do
  use ExUnit.Case
  doctest Queue

  test "succeeds if pid was created" do
    assert {:ok, _pid} = Queue.start_link([])
  end

  test "succeeds if an item was enqueued" do
    {:ok, pid} = Queue.start_link([])

    assert :ok = Queue.enqueue(pid, 1)
  end

  test "succeeds if an item was dequeued" do
    {:ok, pid} = Queue.start_link([])

    Queue.enqueue(pid, 1)

    assert 1 = Queue.dequeue(pid)
  end
end
