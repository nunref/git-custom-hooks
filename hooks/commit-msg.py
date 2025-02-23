#!/usr/bin/python3

"""
    This script will check that the commit title (first line) follows an expected pattern.
"""

import sys
import re

MESSAGE_PATTERN = "(.*): (.*)"
GIT_COMMIT_TYPES = [
    "feat", "fix", "ref", "enh"
]

if __name__=="__main__":
    message_path = sys.argv[1]
    message_regex = re.compile(MESSAGE_PATTERN)
    with open(message_path) as file:
        message = file.readlines()

    if (len(message) < 1):
        print("Empty commit is not accepted.")
    else:
        commit_title = message[0].rstrip()
        if (match := message_regex.match(commit_title)):
            commit_type = match.group(1)
            if (commit_type in GIT_COMMIT_TYPES):
                sys.exit(0)
            else:
                print(f"Commit type '{commit_type}' is not one of the accepted types.")
        else:
            print(f"Commit title '{commit_title}' does not match the expected pattern.")
    sys.exit(1)

