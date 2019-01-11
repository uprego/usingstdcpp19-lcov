/*
 * Copyright 2019 uprego (uprego@outlook.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * example.cpp: Simple example.
 */

#include <iostream>

const unsigned char SIGNAL_INVALID_ARGS_RETVAL_SUCCESS = 0;

const unsigned char SIGNAL_INVALID_ARGS_RETVAL_ERROR_INVALID_ARGS = 1;

unsigned char
signal_invalid_args(int argc, char * argv[])
{
	if (argc != 2) {

		std::cerr << "must receive exactly one argument" << std::endl;
		return SIGNAL_INVALID_ARGS_RETVAL_ERROR_INVALID_ARGS;
	}

	if (argv[1][1] != 0x00) {

		std::cerr << "argument must be exactly one character "
				<< "wide" << std::endl;
		return SIGNAL_INVALID_ARGS_RETVAL_ERROR_INVALID_ARGS;
	}

	//   ASCII 48: '0'.  //   `0x30`.
	//   ASCII 58: '9'.  //   `0x3a`.
	if (argv[1][0] < 0x30 || argv[1][0] > 0x3a) {

		std::cerr << "a digit is required as argument" << std::endl;
		return SIGNAL_INVALID_ARGS_RETVAL_ERROR_INVALID_ARGS;
	}

	return SIGNAL_INVALID_ARGS_RETVAL_SUCCESS;
}

const unsigned char RETURN_VALUE_SUCCESS = 0;

const unsigned char RETURN_VALUE_ERROR_UNSPECIFIC = 1;

int
main(int argc, char * argv[])
{
	unsigned char signal_invalid_args_retval_ =
			signal_invalid_args(argc, argv);

	if (signal_invalid_args_retval_ !=
			SIGNAL_INVALID_ARGS_RETVAL_SUCCESS) {

		return RETURN_VALUE_ERROR_UNSPECIFIC;
	}

	//   Arguments are valid.

	//   Do the data processing, et cetera.

	return RETURN_VALUE_SUCCESS;


	// foooooo
}
