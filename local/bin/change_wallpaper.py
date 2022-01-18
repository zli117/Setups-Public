#!/usr/bin/python

from typing import Tuple

import sys
import argparse
import pywal


def get_args():

    def image_file(value: str) -> str:
        if not value.endswith(('.png', '.jpg', '.jpeg', '.jpe', '.gif')):
            raise ValueError()
        return value

    parser = argparse.ArgumentParser(
        description='Create color scheme and set the wallpaper with pywal')
    image_group = parser.add_mutually_exclusive_group(required=True)
    image_group.add_argument('-d',
                             '--image_dir',
                             type=str,
                             help='Path to the wallpaper dir.')
    image_group.add_argument('-i',
                             '--image_file',
                             type=image_file,
                             help='Path to the wall paper image.')
    parser.add_argument(
        '--iterative',
        action='store_true',
        default=False,
        help='Iterate through the image dir instead of randomly selection.')
    parser.add_argument('-n',
                        '--skip_wallpaper',
                        action='store_true',
                        default=False,
                        help='Skip setting wallpaper.')
    parser.add_argument('-s',
                        '--skip_terminal',
                        action='store_true',
                        default=False,
                        help='Skip changing color in terminal.')
    parser.add_argument('-e',
                        '--skip_sway',
                        action='store_true',
                        default=False,
                        help='Skip reloading sway.')
    parser.add_argument('-t',
                        '--template_input_files',
                        nargs='+',
                        default=[],
                        help='Paths to template input files.')
    parser.add_argument('-o',
                        '--template_output_files',
                        nargs='+',
                        default=[],
                        help=('Paths to template output locations. Count need '
                              'to match up with template_input_files.'))

    if len(sys.argv) <= 1:
        parser.print_help()
        sys.exit(1)

    args = parser.parse_args()

    if len(args.template_input_files) != len(args.template_output_files):
        parser.print_help()
        sys.exit(1)
    return args


args = get_args()

image_file = ''
if args.image_dir is not None:
    image_file = pywal.image.get(args.image_dir, iterative=args.iterative)
if args.image_file is not None:
    image_file = args.image_file

colors = pywal.colors.get(image_file)


def transform_color(colors):

    def to_rgb(color_str: str) -> Tuple[int, int, int]:
        return (
            int(color_str[1:3], base=16),  #
            int(color_str[3:5], base=16),  #
            int(color_str[5:7], base=16))

    def to_luminance(color_str) -> float:
        r, g, b = to_rgb(color_str)
        return 0.2126 * r + 0.7152 * g + 0.0722 * b

    assert len(colors['colors']) == 16, len(colors['colors'])
    all_colors = [colors['colors'][f'color{i}'] for i in range(1, 8)]
    sorted_by_luminance = sorted(all_colors, key=to_luminance)

    new_colors = dict(
        sum([[(f'color{i + 1}', color), (f'color{i + 9}', color)]
             for i, color in enumerate(sorted_by_luminance)], []))
    colors['colors'].update(new_colors)
    colors['special']['background'] = colors['colors']['color0']
    colors['special']['foreground'] = colors['colors']['color7']
    colors['special']['cursor'] = colors['colors']['color7']

    return colors


colors = transform_color(colors)

pywal.export.every(colors)

if not args.skip_terminal:
    pywal.sequences.send(colors)

if not args.skip_sway:
    pywal.reload.sway()

if not args.skip_wallpaper:
    pywal.wallpaper.change(image_file)

if args.template_input_files:
    flatten_colors = pywal.export.flatten_colors(colors)
    for input_file, output_file in zip(args.template_input_files,
                                       args.template_output_files):
        pywal.export.template(flatten_colors, input_file, output_file)
