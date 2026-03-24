import sys, os

import defactocmd,defacto
sys.path.append(os.environ["HIDFT_HOME"]+"/py")


def convert_to_number(item):
    try:
        item = int(item)
        return item
    except ValueError:
        if item.isdigit():
            return int(item)
        elif item.isnumeric() or (item.count('.') == 1 and item.replace('.', '').isdigit()):
            return float(item)
        else:
            raise ValueError('Could not convert {}'.format(item))


#This creates a simple banner string for insertion into code snippets
def create_banner(banner_text, banner_fill='/', width=80, padding=4):
    # Create the top and bottom border
    border = banner_fill * width

    # Calculate left padding for the text
    left_padding    = (banner_fill * ((width - len(banner_text) - (1 * padding)) // 2)) + (' ' * padding)
    right_padding   = (' ' * padding) + (banner_fill * ((width - len(banner_text) - (1 * padding)) // 2))

    # Create the banner text line with padding
    banner_line = f"{left_padding}{banner_text}{right_padding}"

    # Adjust banner_line length to fit the width
    banner_line = banner_line[:width]

    # Combine everything into a single banner
    full_banner = f"{border}\n{banner_line}\n{border}"
    return full_banner



