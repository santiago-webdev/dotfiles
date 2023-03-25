#!/usr/bin/env python3

import sys

hex_list = sys.argv[1:]  # Get the list of HSL values from the command line arguments


def convert_hex_to_hsl(hex_codes):
    """Converts a list of hex color codes to HSL values."""
    hsl_values = []
    for hex_code in hex_codes:
        # Convert hex code to RGB values
        r = int(hex_code[1:3], 16)
        g = int(hex_code[3:5], 16)
        b = int(hex_code[5:7], 16)

        # Find maximum and minimum values for calculating lightness and saturation
        max_val = max(r, g, b)
        min_val = min(r, g, b)
        delta = max_val - min_val

        # Calculate lightness, saturation, and hue values
        l = round((max_val + min_val) * 50 / 255)
        if delta == 0:
            s = 0
            h = 0
        else:
            if l < 50:
                s = round(delta * 100 / (max_val + min_val))
            else:
                s = round(delta * 100 / (510 - max_val - min_val))
            if max_val == r:
                h = round((g - b) * 60 / delta)
            elif max_val == g:
                h = round((b - r) * 60 / delta) + 120
            else:
                h = round((r - g) * 60 / delta) + 240
            if h < 0:
                h += 360

        # Append HSL value as a tuple of integers to list
        hsl_values.append((h, s, l))

    # Return the list of HSL values
    return hsl_values


if __name__ == "__main__":
    hsl_list = convert_hex_to_hsl(hex_list)
    for hsl in hsl_list:
        print(f"hsl({hsl[0]} {hsl[1]}% {hsl[2]}%)")
