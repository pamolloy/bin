#!/usr/bin/env python
#
#   sum-statement.py - Print the sum of a credit card statement
#
# PURPOSE
#   Calculate the sum of all transactions in a monthly credit card statement
#   that is exported as a text file with the transaction amount delimited by
#   "|" 
#
# EXAMPLE
#   python sum-statement.py 01-01-2013.txt
#
# TODO
#   Parse and export text file as JSON
#	Represent currency using integers NOT floats
#

import sys
import re
import locale

def sum_statement(fn):
    """Sum values delimited with the pipe character (i.e. "|")"""

    sum = 0

    with open(fn,'r') as f:
        data = f.read()
    
    # Value between a "$" and "|"
    for value in re.findall('\$(.*?)\|', data):
        value = value.replace(",", "")  # Remove comma
        if value[0] != "-": # If positive value
            sum+=float(value)
        else:   # Handle negative value
            sum-=float(value[1:])   # Remove hyphen

    return sum

locale.setlocale(locale.LC_ALL, '')
# Print the sum of the transaction amounts in the first command-line argument
print(locale.currency(sum_statement(sys.argv[1])))
