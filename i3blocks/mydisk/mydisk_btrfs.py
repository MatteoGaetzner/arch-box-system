#!/usr/bin/env python3

"""
This script extracts disk usage statistics for systems running btrfs as the filesystem of choice.
"""

import os
import re

raw_output = os.popen("sudo btrfs filesystem show --gbytes").read()


def print_disk_usage(label_to_stats: dict) -> None:
    long_out_str = ""
    short_out_str = ""
    for label_ndx, label in enumerate(label_to_stats.keys()):
        used = label_to_stats[label]["used"]
        size = label_to_stats[label]["size"]
        perc = round(100 * used / size)
        long_out_str += f"{label}  {used}G / {size}G  {perc}%"
        short_out_str += f"{label}  {perc}%"
        if label_ndx < len(label_to_stats.keys()) - 1:
            long_out_str += " | "
            short_out_str += " | "
    print(long_out_str)
    print(short_out_str)
    print("#FFFFFF")


try:
    labels = re.findall("Label: '(.+?)'  ", raw_output)
    total_useds = re.findall("FS bytes used (.+)GiB", raw_output)
    label_to_stats = {
        label: {"used": round(float(used)), "size": -1}
        for label, used in zip(labels, total_useds)
    }
    LABEL_NDX = 0
    current_label = labels[LABEL_NDX]
    partition_sizes = []
    for line in raw_output.split("\n"):
        if not line:
            label_to_stats[current_label]["size"] = round(sum(partition_sizes))
            LABEL_NDX += 1
            if LABEL_NDX >= len(labels):
                break
            current_label = labels[LABEL_NDX]
            partition_sizes = []
        else:
            if size := re.search("size (.+)GiB used", line):
                partition_sizes.append(float(size.group(1)))
    print_disk_usage(label_to_stats)
except AttributeError as e:
    print(f"ERROR: {e}")
