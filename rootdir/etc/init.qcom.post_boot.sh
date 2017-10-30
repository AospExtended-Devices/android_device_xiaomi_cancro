#!/system/bin/sh
# Copyright (c) 2012-2013, 2016, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

target=`getprop ro.board.platform`

case "$target" in
    "msm8974")
        echo 4 > /sys/module/lpm_levels/enable_low_power/l2
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/retention/idle_enabled
        echo Y > /sys/module/clock_krait_8974/parameters/boost
        stop mpdecision
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi
        case "$soc_id" in
            "208" | "211" | "214" | "217" | "209" | "212" | "215" | "218" | "194" | "210" | "213" | "216")
                for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor
                do
                    echo "cpubw_hwmon" > $devfreq_gov
                done
                echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                echo "interactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
                echo "interactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
                echo "interactive" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
                echo "0 1100000:40000 1400000:20000 1700000:0" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
                echo 96 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
                echo 925440 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
                echo 0 > /sys/devices/system/cpu/cpufreq/interactive/boost
                echo 0 > /sys/devices/system/cpu/cpufreq/interactive/boostpulse_duration
                echo 1 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
                echo "0 268800:50 487680:35 925440:45 1253760:52 1363200:59 1582080:75 1691520:90 2019840:95 2348160:99" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
                echo 60000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
                echo 268800 > /sys/devices/system/cpu/cpufreq/interactive/sync_freq
		echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
		echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/timer_slack
		echo 0 > /sys/devices/system/cpu/cpufreq/interactive/up_threshold_any_cpu_freq
		echo 0 > /sys/devices/system/cpu/cpufreq/interactive/up_threshold_any_cpu_load
                echo 20 > /sys/module/cpu_boost/parameters/boost_ms
                echo 0 > /sys/module/cpu_boost/parameters/sync_threshold
                echo 1 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
                echo 0 > /sys/module/cpu_boost/parameters/input_boost_freq
                echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
                echo 1 > /sys/kernel/fast_charge/force_fast_charge
                setprop ro.qualcomm.perf.cores_online 2
		# Fuck the YOTA
                # Use kernel feature
                su -c iptables -t mangle -A POSTROUTING -j TTL --ttl-set 64

				# Stripalov TCP fix for cancro. All rights reserved © 2016
				busybox sysctl -w net.ipv4.tcp_timestamps=0
				busybox sysctl -w net.ipv4.tcp_tw_reuse=1
				busybox sysctl -w net.ipv4.tcp_sack=1
				busybox sysctl -w net.ipv4.tcp_tw_recycle=1
				busybox sysctl -w net.ipv4.tcp_window_scaling=1
				busybox sysctl -w net.ipv4.tcp_keepalive_probes=5
				busybox sysctl -w net.ipv4.tcp_keepalive_intvl=30
				busybox sysctl -w net.ipv4.tcp_fin_timeout=30
				busybox sysctl -w net.core.wmem_max=404480
				busybox sysctl -w net.core.rmem_max=404480
				busybox sysctl -w net.core.rmem_default=256960
				busybox sysctl -w net.core.wmem_default=256960
				busybox sysctl -w net.ipv4.tcp_wmem=4096,16384,404480
				busybox sysctl -w net.ipv4.tcp_rmem=4096,87380,404480
				busybox sysctl -w net.ipv4.conf.all.rp_filter=2
				busybox sysctl -w net.ipv4.conf.default.rp_filter=2
				busybox sysctl -w net.ipv4.tcp_max_syn_backlog=1024
				busybox sysctl -w net.ipv4.tcp_synack_retries=2
				busybox sysctl -w net.ipv4.tcp_moderate_rcvbuf=1
				busybox sysctl -w net.ipv4.icmp_echo_ignore_all=1
				busybox sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
				busybox sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
				busybox sysctl -w net.ipv4.tcp_fin_timeout=15
				busybox sysctl -w net.ipv4.route.flush=1
				busybox sysctl -w net.ipv4.tcp_rfc1337=1
				busybox sysctl -w net.ipv4.ip_no_pmtu_disc=0
				busybox sysctl -w net.ipv4.tcp_ecn=0
				busybox sysctl -w net.ipv4.tcp_fack=1
				busybox sysctl -w net.ipv4.tcp_syn_retries=2
				busybox sysctl -w net.ipv4.ip_forward=0
				busybox sysctl -w net.ipv4.conf.all.accept_redirects=0
				busybox sysctl -w net.ipv4.conf.all.secure_redirects=0
				busybox sysctl -w net.ipv4.conf.all.send_redirects=0
				busybox sysctl -w net.ipv4.conf.default.send_redirects=0
				busybox sysctl -w net.ipv4.conf.default.accept_source_route=0
				busybox sysctl -w net.ipv4.tcp_dsack=1
				busybox sysctl -w net.ipv4.tcp_no_metrics_save=1
				busybox sysctl -w net.core.netdev_max_backlog=30000
				busybox sysctl -w net.ipv4.tcp_fastopen=1
				busybox sysctl -w net.ipv4.tcp_slow_start_after_idle=0

				# Stripalov killer for cancro. All rights reserved © 2016 2017
				# Force stop Google Sync
				am force-stop com.google.android.syncadapters.contacts
				# Force stop Google App
				am force-stop com.google.android.googlequicksearchbox
				# Force stop Play Market
				am force-stop com.android.vending
				# Force stop Google Play Services
				am force-stop com.google.android.gms
				# Force stop Google Services Framework
				am force-stop com.google.process.gapps
				# Force stop Google Partner Setup
				am force-stop com.google.android.partnersetup
				# Force stop GBoard
				am force-stop com.google.android.inputmethod.latin
				# Force stop Settings
				am force-stop com.android.settings
				
				# Stripalov OOM fix for cancro. All rights reserved © 2016 2017
				# Fix Google Sync
				echo 15 > /proc/`busybox pidof com.google.android.syncadapters.contacts`/oom_adj
				# Fix Google App
				echo 15 > /proc/`busybox pidof com.google.android.googlequicksearchbox:interactor`/oom_adj | echo 15 > /proc/`busybox pidof com.google.android.googlequicksearchbox:search`/oom_adj
				# Fix Play Market
				echo 15 > /proc/`busybox pidof com.android.vending`/oom_adj
				# Fix Google Play Services
				echo 15 > /proc/`busybox pidof com.google.android.gms`/oom_adj | echo 15 > /proc/`busybox pidof com.google.android.gms.persistent`/oom_adj
				# Fix Google Services Framework
				echo 15 > /proc/`busybox pidof com.google.process.gapps`/oom_adj
				# Fix Google Partner Setup
				echo 15 > /proc/`busybox pidof com.google.android.partnersetup`/oom_adj
				# Fix GBoard
				echo 15 > /proc/`busybox pidof com.google.android.inputmethod.latin`/oom_adj
				# Fix Settings
				echo 15 > /proc/`busybox pidof com.android.settings`/oom_adj

            ;;
            *)
                echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
                echo "ondemand" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
                echo "ondemand" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
                echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
                echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
                echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
                echo 2 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
                echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
                echo 70 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
                echo 3 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
                echo 960000 > /sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
                echo 960000 > /sys/devices/system/cpu/cpufreq/ondemand/sync_freq
                echo 1190400 > /sys/devices/system/cpu/cpufreq/ondemand/input_boost
                echo 80 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load
            ;;
        esac
	echo 0 > /proc/sys/net/ipv4/tcp_timestamps
	echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
	echo 1 > /proc/sys/net/ipv4/tcp_sack
	echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle
	echo 1 > /proc/sys/net/ipv4/tcp_window_scaling
	echo 5 > /proc/sys/net/ipv4/tcp_keepalive_probes
	echo 30 > /proc/sys/net/ipv4/tcp_keepalive_intvl
	echo 30 > /proc/sys/net/ipv4/tcp_fin_timeout
	echo 404480 > /proc/sys/net/core/wmem_max
	echo 404480 > /proc/sys/net/core/rmem_max
	echo 256960 > /proc/sys/net/core/rmem_default
	echo 256960 > /proc/sys/net/core/wmem_default
	echo "4096,16384,404480" > /proc/sys/net/ipv4/tcp_wmem
	echo "4096,87380,404480" > /proc/sys/net/ipv4/tcp_rmem
        echo 268800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 268800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
        echo 268800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
        echo 268800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
        chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
        chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        chown -h root.system /sys/devices/system/cpu/mfreq
        chmod -h 220 /sys/devices/system/cpu/mfreq
        chown -h root.system /sys/devices/system/cpu/cpu1/online
        chown -h root.system /sys/devices/system/cpu/cpu2/online
        chown -h root.system /sys/devices/system/cpu/cpu3/online
        chmod -h 664 /sys/devices/system/cpu/cpu1/online
        chmod -h 664 /sys/devices/system/cpu/cpu2/online
        chmod -h 664 /sys/devices/system/cpu/cpu3/online
        chmod -h 664 /sys/devices/system/cpu/sched_mc_power_savings
        echo 0 > /sys/devices/system/cpu/sched_mc_power_savings
        echo 1 > /dev/cpuctl/apps/cpu.notify_on_migrate
    ;;
esac

case "$target" in
    "msm8974")
         rm /data/system/perfd/default_values
         echo 896 > /sys/block/mmcblk0/bdi/read_ahead_kb
	;;
esac

case "$target" in
    "msm8974")
        # Let kernel know our image version/variant/crm_version
        image_version="10:"
        image_version+=`getprop ro.build.id`
        image_version+=":"
        image_version+=`getprop ro.build.version.incremental`
        image_variant=`getprop ro.product.name`
        image_variant+="-"
        image_variant+=`getprop ro.build.type`
        oem_version=`getprop ro.build.version.codename`
        echo 10 > /sys/devices/soc0/select_image
        echo $image_version > /sys/devices/soc0/image_version
        echo $image_variant > /sys/devices/soc0/image_variant
        echo $oem_version > /sys/devices/soc0/image_crm_version
	;;
esac

chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy

emmc_boot=`getprop ro.boot.emmc`
case "$emmc_boot"
    in "true")
        chown -h system /sys/devices/platform/rs300000a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300000a7.65536/sync_sts
        chown -h system /sys/devices/platform/rs300100a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300100a7.65536/sync_sts
    ;;
esac

# Post-setup services
case "$target" in
    "msm8974")
        start mpdecision
        echo 896 > /sys/block/mmcblk0/bdi/read_ahead_kb
    ;;
esac

# Change console log level as per console config property
console_config=`getprop persist.console.silent.config`
case "$console_config" in
    "1")
        echo "Enable console config to $console_config"
        echo 0 > /proc/sys/kernel/printk
        ;;
    *)
        echo "Enable console config to $console_config"
        ;;
esac

