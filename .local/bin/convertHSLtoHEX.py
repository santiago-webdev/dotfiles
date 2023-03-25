#!/usr/bin/env python3

import sys

hsl_list = sys.argv[1:]  # Get the list of HSL values from the command line arguments


def convert_hsl_to_hex(hsl_list):
    for hsl in hsl_list:
        h, s, l = [int(x.strip("%")) for x in hsl.split()]
        h /= 360
        s /= 100
        l /= 100
        if s == 0:
            r, g, b = l, l, l
        else:

            def hue_to_rgb(p, q, t):
                if t < 0:
                    t += 1
                if t > 1:
                    t -= 1
                if t < 1 / 6:
                    return p + (q - p) * 6 * t
                if t < 1 / 2:
                    return q
                if t < 2 / 3:
                    return p + (q - p) * (2 / 3 - t) * 6
                return p

            q = l * (1 + s) if l < 0.5 else l + s - l * s
            p = 2 * l - q
            r = hue_to_rgb(p, q, h + 1 / 3)
            g = hue_to_rgb(p, q, h)
            b = hue_to_rgb(p, q, h - 1 / 3)

        hex_value = "#{0:02x}{1:02x}{2:02x}".format(
            int(r * 255), int(g * 255), int(b * 255)
        )
        print(hex_value)


if __name__ == "__main__":
    convert_hsl_to_hex(hsl_list)
