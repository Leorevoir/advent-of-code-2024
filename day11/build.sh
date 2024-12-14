#!/usr/bin/env bash

function find_c_files()
{
    local src_dir="$1"

    find "$src_dir" -type f -name '*.c'
}

function create_makefile()
{
    local src_files="$1"
    local name="$2"

    {
        cat << EOF
##
## EPITECH PROJECT, 2024
## $(basename "$PWD")
## File description:
## Auto generated Makefile, do not edit
##

CFLAGS = -I./include -Wall -Wextra -Werror -g3 -pedantic -Wconversion

ADDFLAGS = # NO ADDITIONAL FLAGS SET 

OBJ_DIR = object

SRC = \\
EOF
        for file in $src_files; do
            echo "	$file \\"
        done
        cat << EOF

OBJ := \$(patsubst src/%.c, \$(OBJ_DIR)/%.o, \$(SRC))

NAME = $name

all: \$(NAME)

\$(OBJ_DIR)/%.o: src/%.c
	@mkdir -p \$(@D)
	@gcc \$(CFLAGS) -o \$@ -c \$<

\$(NAME): \$(OBJ)
	@gcc \$(CFLAGS) -o \$(NAME) \$^ \$(ADDFLAGS)
	@printf "[\033[1;32mSUCCESS\033[0m] Compiled %s\n" \$(NAME)

clean:
	@rm -rf \$(OBJ_DIR)
	@printf "[\033[1;32mCLEAN\033[0m] Removed object directory\n"

fclean: clean
	@rm -f \$(NAME)
	@rm -f coding-style-reports.log
	@printf "[\033[1;32mFCLEAN\033[0m] Removed %s\n" \$(NAME)

re: fclean all

.PHONY: all clean fclean re
EOF
    } > Makefile
}

function parse_c_files()
{
    C_FILES=$(find_c_files "$SRC_DIR")

    if [ -z "$C_FILES" ]; then
        echo "ERROR: No C files found in $SRC_DIR"
        exit 84
    fi

    create_makefile "$C_FILES" "$NAME"
}

function parse_arguments()
{
    if [ "$#" -ne 1 ]; then
        echo "USAGE: $0 <executable_name>"
        exit 84
    fi

    SRC_DIR="src"
    NAME="$1"
    parse_c_files
}

# parse_arguments "$@"
parse_arguments "day11" && make
