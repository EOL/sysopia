module Sysopia
  class Stat
    DATA = {
      load_one: {
        description: "Average Load 1min",
        unit: "%",
        multiplier: 100
      },
      load_five: {
        description: "Average Load 5min",
        unit: "%",
        multiplier: 100
      },
      load_fifteen: {
        description: "Average Load 15min",
        unit: "%",
        multiplier: 100
      },
      cpu_user: {
        description: "User time on cpu",
        unit: "%",
        multiplier: 100
      },
      cpu_system: {
        description: "System time on cpu",
        unit: "%",
        multiplier: 100
      },
      cpu_busy: {
        description: "Percent of time cpu is active",
        unit: "%",
        multiplier: 100
      },
      cpu_wait: {
        description: "Percent of time cpu waits for IO",
        unit: "%",
        multiplier: 100
      },
      io_read: {
        description: "Reads from disk to memory",
        unit: "MB/sec",
        multiplier: 1
      },
      io_write: {
        description: "Write to disk from memory",
        unit: "MB/sec",
        multiplier: 1
      },
      swap_used: {
        description: "Amount of swap memory engaged",
        unit: "MB",
        multiplier: 1
      },
      swap_in: {
        description: "Memory moved to swap",
        unit: "MB",
        multiplier: 1
      },
      swap_out: {
        description: "Memory moved from swap",
        unit: "MB",
        multiplier: 1
      },
      memory_taken: {
        description: "Percent of used memory",
        unit: "%",
        multiplier: 1
      },
      processes_waiting: {
        description: "Number of processes waiting in queue",
        unit: nil,
        multiplier: 1
      },
      processes_iowaiting: {
        description: "Number of processes locked in IO wait",
        unit: nil,
        multiplier: 1
      }
    }
  end
end
