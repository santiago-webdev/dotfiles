#!/usr/bin/env python3

import sys

hex_list = sys.argv[1:]  # Get the list of HSL values from the command line arguments


def convert_hex_to_hsl(hex_codes):
    """Converts a list of hex color codes to HSL values."""
    hsl_values = []
    for hex_code in hex_codes:
        # Convert hex code to RGB values
        r = int(hex_code[1:3], 16) / 255
        g = int(hex_code[3:5], 16) / 255
        b = int(hex_code[5:7], 16) / 255

        # Find maximum and minimum values for calculating lightness and saturation
        max_val = max(r, g, b)
        min_val = min(r, g, b)
        delta = max_val - min_val

        # Calculate lightness, saturation, and hue values
        l = (max_val + min_val) / 2
        if delta == 0:
            s = 0
            h = 0
        else:
            if l < 0.5:
                s = delta / (max_val + min_val)
            else:
                s = delta / (2 - max_val - min_val)
            if max_val == r:
                h = (g - b) / delta
            elif max_val == g:
                h = 2 + (b - r) / delta
            else:
                h = 4 + (r - g) / delta
            h *= 60
            if h < 0:
                h += 360

        # Append HSL value as a tuple of floats to list
        hsl_values.append((round(h, 2), round(s * 100, 2), round(l * 100, 2)))
        print(hex_code)


if __name__ == "__main__":
    convert_hex_to_hsl(hex_list)
