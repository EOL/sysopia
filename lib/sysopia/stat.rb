module Sysopia
  class Stat
    DATA = {
      load_one: {
        description: "Average Load",
        unit: "%",
        multiplier: 100
      },
      load_five: {
        description: "Average Load 5 Min",
        unit: "%",
        multiplier: 100
      },
      load_fifteen: {
        description: "Average Load 15 Min",
        unit: "%",
        multiplier: 100
      },
      cpu_user: {
        description: "User Time on CPU",
        unit: "%",
        multiplier: 100
      },
      cpu_system: {
        description: "System Time on CPU",
        unit: "%",
        multiplier: 100
      },
      cpu_busy: {
        description: "Percent of Time CPU is Active",
        unit: "%",
        multiplier: 100
      },
      cpu_wait: {
        description: "Percent of Time CPU Waits for IO",
        unit: "%",
        multiplier: 100
      },
      io_read: {
        description: "Reads from Disk",
        unit: "MB/sec",
        multiplier: 1
      },
      io_write: {
        description: "Writes to Disk",
        unit: "MB/sec",
        multiplier: 1
      },
      swap_used: {
        description: "Amount of Swap Memory Engaged",
        unit: "MB",
        multiplier: 1
      },
      swap_in: {
        description: "Memory Moved to Swap",
        unit: "MB",
        multiplier: 1
      },
      swap_out: {
        description: "Memory Moved from Swap",
        unit: "MB",
        multiplier: 1
      },
      memory_taken: {
        description: "Memory Usage",
        unit: "%",
        multiplier: 1
      },
      processes_waiting: {
        description: "Number of Processes Waiting in Queue",
        unit: nil,
        multiplier: 1
      },
      processes_iowaiting: {
        description: "Number of Processes Locked in IO Wait",
        unit: nil,
        multiplier: 1
      },
      disk_usage: {
        description: "Max Partition Usage",
        unit: "%",
        multiplier: 1
      }
    }
  end
end
