class StatusController < ApplicationController
    private

    # def get_time
    #     t = Time.now
    #     t.strftime('%H:%M')
    # end

    def get_temps
        temps = `g currenttemp`
        temps.gsub!('temp=','')
        temps
    end

    def get_diskspace
        `g diskspace`
    end

    def get_amount_of_downloads
        `g torrent check | wc -l`
    end

    def get_cpu_idle
        stats = `mpstat`
        stat_array = stats.split(' ')
        idle = stat_array.last.gsub!(',','.')
        idle.to_f
    end

    def get_cpu_load
        cpu_load = 100 - get_cpu_idle
        cpu_load.round(2)
    end

    public
    
    def index
        #@time = get_time
        @temp = get_temps
        @diskspace = get_diskspace
        @downloads = get_amount_of_downloads
        @load = get_cpu_load
        @idle = get_cpu_idle
    end
end