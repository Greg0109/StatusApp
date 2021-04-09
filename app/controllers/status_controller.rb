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

    def get_storage_space
        space = `df -h /home/pi/Desktop/Storage/ | awk '{print $2, $3, $4, $5}' | awk 'FNR==2'`
        spacearray = space.split(' ')
    end

    def get_amount_of_downloads
        `g torrent check | wc -l`
    end

    def get_cpu_idle
        stats = `mpstat`
        stat_array = stats.split(' ')
        stat_array.last.to_f
    end

    def get_cpu_load
        cpu_idle = get_cpu_idle
        cpu_load = 100 - cpu_idle
        cpu_load.round(2)
    end

    public
    
    def index
        #@time = get_time
        @temp = get_temps
        @diskspace = get_diskspace
        @storagespace = get_storage_space
        @downloads = get_amount_of_downloads
        @idle = get_cpu_idle
        @load = get_cpu_load
    end
end