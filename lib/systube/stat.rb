module SysTube
  class Stat
    DATA = {
      load_one: {
        description: "Average Load 1min",
        unit: nil
      },
      load_five: {
        description: "Average Load 5min",
        unit: nil
      },
      load_fifteen: {
        description: "Average Load 15min",
        unit: nil
      },
      cpu_user: {
        description: "User time on cpu",
        unit: "%"
      },
      cpu_system: {
        description: "System time on cpu",
        unit: "%"
      },
      cpu_busy: {
        description: "Percent of time cpu is active",
        unit: "%"
      },
      cpu_wait: {
        description: "Percent of time cpu waits for IO",
        unit: "%"
      },
      io_read: {
        description: "Reads from disk to memory",
        unit: "MB/sec"
      },
      io_write: {
        description: "Write to disk from memory",
        unit: "MB/sec"
      },
      swap_used: {
        description: "Amount of swap memory engaged",
        unit: "MB"
      },
      swap_in: {
        description: "Memory moved to swap",
        unit: "MB"
      },
      swap_out: {
        description: "Memory moved from swap",
        unit: "MB"
      },
      memory_taken: {
        description: "Percent of used memory",
        unit: "%"
      },
      processes_waiting: {
        description: "Number of processes waiting in queue",
        unit: nil
      },
      processes_iowaiting: {
        description: "Number of processes locked in IO wait",
        unit: nil
      }
    }
  end
end
