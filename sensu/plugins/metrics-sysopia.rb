#!/opt/sensu/embedded/bin/ruby
#  encoding: UTF-8
#  Metrics System Plugin
#
# DESCRIPTION:
#   This plugin uses vmstat, uptime, free, cpuinfo  to collect basic system
#   metrics, produces Gphite formated output.
#
# OUTPUT:
#   metric data
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   apps: vmstat, ifstat, free, uptime
#
# USAGE:
#
# NOTES:
#
# LICENSE:
#   Heavily based on vmstat metric plugin by Sonian, Inc <chefs@sonian.net>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/metric/cli'
require 'socket'



class SysMetrics < Sensu::Plugin::Metric::CLI::Graphite

  def initialize
    @vmstat = convert_floats(`vmstat 1 2|tail -n1`.split(' '))
    @memstat = convert_floats(`free|tail -n2|head -n1`.split(' '))
    @cpunum =  `cat /proc/cpuinfo |grep processor|wc -l`.to_i
    @loadstat = `uptime`.strip.split(' ').map { |s| s.to_f }
    @diskusage = `df -lPT |awk '$2 !~ /Type|tmp/ { print $6 }'| sed 's/%//'| sort -n|tail -n1`.to_i
  end

  def convert_floats(values)
    values.each_with_index do |value, index|
      begin
        converted = Integer(value.gsub(',',''))
        values[index] = Float(converted)
      rescue ArgumentError
      end
    end
    values
  end

  def run
    timestamp = Time.now.to_i
    freemem = @memstat[-1]
    totalmem = freemem + @memstat[-2]
    percentmem = (totalmem - freemem)/totalmem.to_f*100
    metrics = {
      procs: {
        waiting: @vmstat[0],
        uninterruptible: @vmstat[1]
      },
      memory: {
        percent: percentmem.round(2),
        total: (totalmem/1024.0).round(2),
      },
      swap: {
        swap_used: (@vmstat[2]/1024.0).round(2),
        in: (@vmstat[6]/1024.0).round(2),
        out: (@vmstat[7]/1024.0).round(2)
      },
      io: {
        read: (@vmstat[8]/1024.0).round(2),
        write: (@vmstat[9]/1024.0).round(2)
      },
      system: {
        interrupts_per_second: @vmstat[10],
        context_switches_per_second: @vmstat[11]
      },
      cpu: {
        number: @cpunum,
        user: @vmstat[12],
        system: @vmstat[13],
        busy: (100 - @vmstat[14]),
        iowaiting: @vmstat[15]
      },
      load_per_cpu: {
        one_minute: (@loadstat[-3]/@cpunum).round(2),
        five_minutes: (@loadstat[-2]/@cpunum).round(2),
        fifteen_minutes: (@loadstat[-1]/@cpunum).round(2)
      },
      disk: { usage: @diskusage }
    }
    metrics.each do |parent, children|
      children.each do |child, value|
        output [Socket.gethostname, "system", parent, child].join('.'),
          value, timestamp
      end
    end
    ok
  end
end
