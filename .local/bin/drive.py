#!/usr/bin/env python

# DESCRIPTION: This is a "simple" wrapper to mount/unmount encrypted devices, it was
# created to mount one drive at a time, that uses the mapper cryptdata, which might be
# changed in the future, you can use it as such:
# To mount a drive:
# drive.py /dev/sda1 --action=mount -o=defaults,noatime,autodefrag,compress-force=zstd:1,space_cache=v2,subvol=@
# To unmount the drive that you mounted earlier:
# drive.py --action=umount

import argparse
import os
import sys


def get_args():
    parser = argparse.ArgumentParser()  # Initialize parser
    default_mount_point: str = os.getenv("HOME") + "/.local/mnt/"

    # Adding optional argument
    parser.add_argument(
        "-a",
        "--action",
        required=True,
        help="Action that you want to do on the --drive",
    )

    parser.add_argument(
        "drive",
        nargs="?",
        help="Drive that you want to mount, for example /dev/sda1.",
    )

    parser.add_argument(
        "-m",
        "--mount-point",
        nargs="?",
        default=default_mount_point,  # If a mount point is not provided use this
        type=str,
        help=("Mounting point for the drive, defaults to " + default_mount_point + "."),
    )

    parser.add_argument(
        "-o",
        "--options",
        nargs="?",  # Using a "*" will make this argument return a list
        default=None,  # If options are not specified do nothing
        type=str,
        help="Filesystem options to use when mounting the drive",
    )

    # Read arguments from command line
    args: argparse.Namespace = parser.parse_args()
    return args  # This is the table-like object that contains all the info


class Drive:
    def __init__(self, drive, mount_point, action, opts) -> None:
        self.opts: str | None = opts
        self.action: str = action  # Will be evaluated in a match statement
        self.drive: str = drive
        self.dir: str = self.eval_mount_point(mount_point)
        self.crypt: str = "cryptdata"  # TODO(santigo-zero): Add a parser to change this
        self.mapper: str = f"/dev/mapper/{self.crypt}"

    def print_stats(self) -> None:
        print("\nPrinting stats:")
        print(self.drive)
        print(self.action)
        print(self.dir)

    def eval_mount_point(self, mount_point) -> str:
        if not os.path.isdir(mount_point):
            print("Creating the mounting point at", mount_point)
            os.mkdir(mount_point)

        return mount_point

    def eval_drive(self, drive) -> str:
        try:
            if not os.path.exists(drive):  # If the drive can't be found
                raise FileNotFoundError  # Then throw error
        except FileNotFoundError:
            print("Drive doesn't exists")  # Because the drive wasn't found :P
            sys.exit(1)
        else:
            return drive  # Else return the drive path, for example /dev/sda1

    def take_action(self) -> str:
        match self.action:
            case "mount":
                return self.mount()
            case "umount":
                return self.umount()
            case other:
                print(f"Unknown command: {other!r}.")
                sys.exit(1)

    def mount(self) -> None:
        self.eval_drive(self.drive)
        mount_drive = os.popen(f"sudo cryptsetup luksOpen {self.drive} {self.crypt}")

        # If the exit code doesn't exists on close() mount the crypt device
        if not mount_drive.close() == None:
            return "There was a problem while opening the crypt label"
            # sys.exit(1)

        if self.opts:
            print("Using provided opts")
            os.popen(f"sudo mount -o {self.opts} {self.mapper} {self.dir}")
        else:
            os.popen(f"sudo mount {self.mapper} {self.dir}")

        return "Mounting the drive in the background, wait a second"

    def umount(self) -> None:
        os.system("sudo umount " + self.dir)
        os.system("sudo cryptsetup close " + self.crypt)

        return "Unmounted the drive at " + self.dir


def main():
    args = get_args()
    drive = Drive(args.drive, args.mount_point, args.action, args.options)
    action = drive.take_action()
    print(action)
    # drive.print_stats()


if __name__ == "__main__":
    # This script was not made to be run as root
    if os.environ.get("USER") == "root" or os.getuid() == 0:
        print("Please run this script as a normal user")
        sys.exit(1)

    main()
